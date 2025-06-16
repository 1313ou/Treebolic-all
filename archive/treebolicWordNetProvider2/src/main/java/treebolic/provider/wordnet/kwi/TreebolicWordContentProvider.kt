package treebolic.provider.wordnet.kwi

import android.annotation.SuppressLint
import android.app.SearchManager
import android.content.ContentProvider
import android.content.ContentValues
import android.content.Context
import android.content.UriMatcher
import android.database.Cursor
import android.database.MatrixCursor
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.util.Log
import androidx.preference.PreferenceManager
import org.kwi.Dictionary
import org.kwi.IDictionary
import treebolic.provider.wordnet.kwi.AndroidDataManager.Companion.getSourceZipURL
import treebolic.provider.wordnet.kwi.TreebolicWordContentProviderContract.makeAuthority
import java.io.File
import java.io.IOException

/**
 * WordNet provider
 *
 * @author [Bernard Bou](mailto:1313ou@gmail.com)
 */
class TreebolicWordContentProvider : ContentProvider() {

    override fun onCreate(): Boolean {
        return true
    }

    // C L O S E

    /**
     * Close provider
     */
    @Suppress("EmptyMethod")
    private fun close() {
    }

    override fun call(method: String, arg: String?, extras: Bundle?): Bundle? {
        if (CALLED_REFRESH_METHOD == method) {
            close()
        }
        return null
    }

    // M I M E

    override fun getType(uri: Uri): String {
        if (uriMatcher.match(uri) == SUGGEST_WORDS) {
            return VENDOR + ".android.cursor.dir/" + VENDOR + '.' + AUTHORITY + '.' + TreebolicWordContentProviderContract.SuggestWords.URI
        }
        throw UnsupportedOperationException("Illegal MIME type")
    }

    // Q U E R Y

    /**
     * Query
     *
     * @param uri            uri
     * @param projection0    projection
     * @param selection0     selection
     * @param selectionArgs0 selection arguments
     * @param sortOrder0     sort order
     * @return cursor
     */
    override fun query(uri: Uri, projection0: Array<String>?, selection0: String?, selectionArgs0: Array<String>?, sortOrder0: String?): Cursor? {
        val code = uriMatcher.match(uri)
        if (code == UriMatcher.NO_MATCH) {
            throw RuntimeException("Malformed URI $uri")
        }

        if (code == SUGGEST_WORDS) {
            // query
            var query = if (selectionArgs0 != null && selectionArgs0.size == 1) selectionArgs0[0] else null
            if (query.isNullOrEmpty() || SearchManager.SUGGEST_URI_PATH_QUERY == query) {
                return null
            }

            // handle space
            query = query.replace(' ', '_')

            // limit from parameter
            var limit = 20
            val limitParameter = uri.getQueryParameter(SearchManager.SUGGEST_PARAMETER_LIMIT)
            if (!limitParameter.isNullOrEmpty()) {
                limit = limitParameter.toInt()
            }

            // context
            val context = checkNotNull(context)
            // source data
            val dataValue = getStringPref(context, PREF_WORDNET_SOURCE, DataManager.OEWN_TAG)

            // cache
            val dir = getStringPref(context, PREF_WORDNET_DIR, null)

            checkNotNull(dataValue)
            return queryWords(dataValue, if (dir != null) File(dir) else context.filesDir, query, limit)
        }
        return null
    }

    // W R I T E O P E R A T I O N S

    override fun delete(uri: Uri, selection: String?, selectionArgs: Array<String>?): Int {
        return 0
    }

    override fun insert(uri: Uri, values: ContentValues?): Uri {
        return uri
    }

    override fun update(uri: Uri, values: ContentValues?, selection: String?, selectionArgs: Array<String>?): Int {
        return 0
    }

    companion object {

        private const val TAG = "WordContentProvider"

        private const val VENDOR = "treebolic_words"

        private const val SCHEME = "content://"

        /**
         * Suggest code
         */
        private const val SUGGEST_WORDS = 900

        /**
         * Wordnet source preference name
         */
        private const val PREF_WORDNET_SOURCE = "pref_wordnet_source"

        /**
         * Wordnet source preference name
         */
        private const val PREF_WORDNET_DIR = "pref_wordnet_dir"

        // C O N T E N T   P R O V I D E R   A U T H O R I T Y

        private val AUTHORITY = makeAuthority()

        // U R I M A T C H E R

        private val uriMatcher = UriMatcher(UriMatcher.NO_MATCH)

        init {
            matchURIs()
        }

        private fun matchURIs() {
            uriMatcher.addURI(AUTHORITY, TreebolicWordContentProviderContract.SuggestWords.URI, SUGGEST_WORDS)
            uriMatcher.addURI(AUTHORITY, TreebolicWordContentProviderContract.SuggestWords.URI + "/*", SUGGEST_WORDS)
        }

        fun makeUri(table: String): String {
            return "$SCHEME$AUTHORITY/$table"
        }

        /**
         * Refresh method name
         */
        const val CALLED_REFRESH_METHOD: String = "closeProvider"

        /**
         * Close provider
         *
         * @param context context
         */
        fun close(context: Context) {
            val uri = Uri.parse(SCHEME + AUTHORITY)
            closeProvider(context, uri)
        }

        /**
         * Close provider
         *
         * @param context context
         * @param uri     provider uri
         */
        private fun closeProvider(context: Context, uri: Uri) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                context.contentResolver.refresh(uri, null, null)
            } else {
                context.contentResolver.call(uri, CALLED_REFRESH_METHOD, null, null)
            }
        }

        // D I C T I O N A R Y

        /**
         * Make dictionary
         *
         * @param dataTag data tag: WN31, OEWN22
         * @param dataDir target directory
         * @return dictionary
         * @throws IOException io exception
         */
        @Throws(IOException::class)
        private fun makeDictionary(dataTag: String, dataDir: File): IDictionary {
            // prepare data dir
            val sourceUrl = getSourceZipURL(dataTag)
            val manager: BaseDataManager = AndroidDataManager()
            val base = manager.getDataDir(sourceUrl, dataDir)

            // construct the dictionary object and open it
            val dictionary: IDictionary = Dictionary(base)
            if (!dictionary.isOpen) {
                dictionary.open()
            }
            return dictionary
        }

        /**
         * Query words
         *
         * @param dataTag data tag: WN31, OEWN22
         * @param dir     target directory for dictionary
         * @param query   word start
         * @param limit   limit
         * @return cursor
         */
        private fun queryWords(dataTag: String, dir: File, query: String, limit: Int): Cursor {
            var dictionary: IDictionary? = null
            try {
                dictionary = makeDictionary(dataTag, dir)
                return queryWords(query, dictionary, limit)
            } catch (e: IOException) {
                Log.e(TAG, "Error making dictionary", e)
                throw RuntimeException(e)
            } finally {
                dictionary?.close()
            }
        }

        /**
         * Query for words starting with
         *
         * @param query      start
         * @param dictionary dictionary
         * @param limit      limit
         * @return cursor
         */
        @SuppressLint("ObsoleteSdkInt")
        private fun queryWords(query: String, dictionary: IDictionary, limit: Int): Cursor {
            val results = dictionary.getLemmasStartingWith(query, null, limit)

            val cursor = MatrixCursor(arrayOf("_id", SearchManager.SUGGEST_COLUMN_TEXT_1, SearchManager.SUGGEST_COLUMN_QUERY))
            var count = 0
            for (result in results) {
                ++count

                // handle space
                val result2 = result.replace('_', ' ')

                // row
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
                    cursor.newRow()
                        .add("_id", ++count)
                        .add(SearchManager.SUGGEST_COLUMN_TEXT_1, result2)
                        .add(SearchManager.SUGGEST_COLUMN_QUERY, result2)
                } else {
                    cursor.addRow(arrayOf<Any>(count, result, result2))
                }
            }

            return cursor
        }

        /**
         * Get string preference
         *
         * @param context      context
         * @param key          key
         * @param defaultValue default value
         * @return value
         */
        private fun getStringPref(context: Context, key: String, defaultValue: String?): String? {
            val sharedPrefs = PreferenceManager.getDefaultSharedPreferences(context)
            return sharedPrefs.getString(key, defaultValue)
        }
    }
}
