/*
 * Copyright (c) 2019-2023. Bernard Bou
 */
package treebolic.provider.wordnet.kwi

import org.kwi.Dictionary
import org.kwi.IDictionary
import org.kwi.item.POS
import org.kwi.item.Pointer
import org.kwi.item.SenseID
import org.kwi.item.Synset
import org.kwi.item.SynsetID
import java.io.Closeable
import java.io.File
import java.io.IOException
import java.util.Collections

class TreebolicTextProvider(dictDir: File) : Closeable {

    /**
     * The WordNet dictionary dir
     */
    private val dict: IDictionary = Dictionary(dictDir)

    init {
        dict.open()
    }

    override fun close() {
        dict.close()
    }

    @OptIn(ExperimentalStdlibApi::class)
    private fun walkLemma(sb: StringBuilder, source: String) {
        var lemma = source
        val cut = source.indexOf(',')
        if (cut != -1) {
            val fields = source.split(",".toRegex()).dropLastWhile { it.isEmpty() }.toTypedArray()
            lemma = fields[0]
            sb.append(lemma).append('\n')
            val posField = if (fields.size > 1) fields[1] else null
            if (!posField.isNullOrEmpty()) {
                val pos = POS.getPartOfSpeech(posField[0])
                sb.append('■').append(' ').append(pos.name).append('\n')
                val idx = dict.getIndex(lemma, pos)
                if (idx != null) {
                    sb.append('◆').append(" lemma = ").append(idx.lemma).append('\n')
                    val senses = idx.senseIDs // synset id, sense number, and lemma
                    val numberField = if (fields.size > 2) fields[2] else null
                    if (!numberField.isNullOrEmpty()) {
                        val senseNumber = numberField.toInt()
                        val senseidx = senses[senseNumber - 1]
                        walkSense(sb, senseidx)
                        return
                    }
                    for (senseidx in senses)  // synset id, sense number, and lemma
                    {
                        walkSense(sb, senseidx)
                    }
                }
            }

            return
        }

        // all poses, all senses
        sb.append(lemma).append('\n')
        for (pos in POS.entries) {
            sb.append('■').append(' ').append(pos.name).append('\n')
            val idx = dict.getIndex(lemma, pos) // a line in an index file
            if (idx != null) {
                sb.append('◆').append(" lemma = ").append(idx.lemma).append('\n')

                val senses = idx.senseIDs // synset id, sense number, and lemma
                for (senseidx in senses)  // synset id, sense number, and lemma
                {
                    walkSense(sb, senseidx)
                }
            }
        }
    }

    private fun walkSense(sb: StringBuilder, senseidx: SenseID) {
        // IWord synset_word = dict.getWord(senseidx); // an index word paired with a synset
        val synsetid = senseidx.synsetID
        val synset = checkNotNull(dict.getSynset(synsetid))
        sb.append('●').append(' ')
        appendSynset(sb, synset).append('\n')

        walkLinks(sb, synset, "  ")
    }

    private fun walkSynset(sb: StringBuilder, sid: String) {
        sb.append(sid).append('\n')
        val synsetid: SynsetID = SynsetID.parseSynsetID(sid)
        val synset = checkNotNull(dict.getSynset(synsetid))
        sb.append('●').append(' ')
        appendSynset(sb, synset).append('\n')

        walkLinks(sb, synset, "  ")
    }

    /**
     * Utility class for sorting
     *
     * @author Bernard Bou
     */
    private enum class Link(private val p: Pointer, val recurses: Boolean) {

        HYPERNYM(Pointer.HYPERNYM, true),
        HYPONYM(Pointer.HYPONYM, true),
        HYPERNYM_INSTANCE(Pointer.HYPERNYM_INSTANCE, true),
        HYPONYM_INSTANCE(Pointer.HYPONYM_INSTANCE, true),

        HOLONYM_PART(Pointer.HOLONYM_PART, true),
        MERONYM_PART(Pointer.MERONYM_PART, true),
        HOLONYM_MEMBER(Pointer.HOLONYM_MEMBER, true),
        MERONYM_MEMBER(Pointer.MERONYM_MEMBER, true),
        HOLONYM_SUBSTANCE(Pointer.HOLONYM_SUBSTANCE, true),
        MERONYM_SUBSTANCE(Pointer.MERONYM_SUBSTANCE, true),

        ENTAILS(Pointer.ENTAILMENT, true),
        ENTAILED(Pointer.IS_ENTAILED, true),
        CAUSES(Pointer.CAUSE, true),
        CAUSED(Pointer.IS_CAUSED, true),

        ANTONYM(Pointer.ANTONYM, false),

        SIMILAR(Pointer.SIMILAR_TO, false),
        ALSO(Pointer.ALSO_SEE, false),
        ATTRIBUTE(Pointer.ATTRIBUTE, false),

        VERBGROUP(Pointer.VERB_GROUP, false),
        PARTICIPLE(Pointer.PARTICIPLE, false),
        PERTAINYM(Pointer.PERTAINYM, false),

        DERIVATION(Pointer.DERIVATIONALLY_RELATED, false),
        DERIVATION_ADJ(Pointer.DERIVED_FROM_ADJ, false),

        DOMAIN_TOPIC(Pointer.TOPIC, false),
        HASDOMAIN_TOPIC(Pointer.TOPIC_MEMBER, false),
        DOMAIN_REGION(Pointer.REGION, false),
        HASDOMAIN_REGION(Pointer.REGION_MEMBER, false),
        DOMAIN_USAGE(Pointer.USAGE, false),
        HASDOMAIN_USAGE(Pointer.USAGE_MEMBER, false),
        DOMAIN(Pointer.DOMAIN, false),
        HASDOMAIN(Pointer.MEMBER, false);

        @OptIn(ExperimentalStdlibApi::class)
        companion object {

            val map: MutableMap<Pointer, Link> = HashMap()

            init {
                for (l in entries) {
                    map[l.p] = l
                }
            }

            val sort: Comparator<Pointer> = Comparator { p1: Pointer, p2: Pointer ->
                val l = map[p1]
                l?.compareTo(map[p2]!!) ?: -1
            }
        }
    }

    /**
     * Walk synset links
     *
     * @param sb     string builder
     * @param synset synset
     */
    private fun walkLinks(sb: StringBuilder, synset: Synset, @Suppress("SameParameterValue") indent: CharSequence) {
        val links = synset.relatedSynsets
        val linkList: List<Pointer> = ArrayList(links.keys)
        Collections.sort(linkList, Link.sort)
        for (p in linkList) {
            sb.append(indent).append('▶').append(' ').append(p.name).append('\n')
            val links2 = checkNotNull(links[p])
            for (synsetid2 in links2) {
                val synset2 = checkNotNull(dict.getSynset(synsetid2))
                sb.append(indent)
                appendSynset(sb, synset2).append('\n')

                walkLinkRecurse(sb, synset2, p, 0, indent)
            }
        }
    }

    /**
     * Walk synset links
     *
     * @param sb     string builder
     * @param synset synset
     * @param p      pointer type to use as a filter
     * @param level  level
     */
    private fun walkLinkRecurse(sb: StringBuilder, synset: Synset, p: Pointer, level: Int, indent: CharSequence) {
        // if (level > deepest)
        //  deepest = level
        val indentSpace = String(CharArray(level)).replace('\u0000', '\t')
        val links2 = synset.getRelatedSynsetsFor(p)
        for (synsetid2 in links2) {
            val synset2 = dict.getSynset(synsetid2)
            if (synset2 != null) {
                sb.append(indent).append(indentSpace)
                appendSynset(sb, synset2).append('\n')

                val l = Link.map[p]
                if (l != null && l.recurses && level < MAX_DEPTH) {
                    walkLinkRecurse(sb, synset2, p, level + 1, indent)
                }
            }
        }
    }

    /**
     * Append synset
     *
     * @param sb     string builder
     * @param synset synset
     * @return sb for chaining
     */
    private fun appendSynset(sb: StringBuilder, synset: Synset): StringBuilder {
        appendMembers(sb, synset).append(' ')
        sb.append(synset.gloss)
        return sb
    }

    /**
     * Append synset members
     *
     * @param sb     string builder
     * @param synset synset
     * @return sb for chaining
     */
    private fun appendMembers(sb: StringBuilder, synset: Synset): StringBuilder {
        sb.append('{')
        var first = true
        for (w in synset.senses) {
            if (first) {
                first = false
            } else {
                sb.append(' ')
            }
            sb.append(w.lemma)
        }
        sb.append('}')
        return sb
    }

    companion object {

        private const val MAX_DEPTH = 3

        private const val WORDNETSCHEME = "wordnet:"

        private const val IDPREFIX = "$WORDNETSCHEME@"

        private const val SYNSETPREFIX = IDPREFIX + "SID-"

        // C O N T E N T

        fun getContent(dataDir: File, source: String): CharSequence? {
            try {
                TreebolicTextProvider(dataDir).use { provider ->
                    val sb = StringBuilder()
                    if (source.startsWith(SYNSETPREFIX)) {
                        val sid = source.substring(IDPREFIX.length)
                        provider.walkSynset(sb, sid)
                    } else {
                        provider.walkLemma(sb, source)
                    }
                    return sb
                }
            } catch (_: IOException) {
                return null
            }
        }
    }
}
