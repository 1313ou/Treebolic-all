/*
 * Copyright (c) 2019-2023. Bernard Bou
 */
package treebolic.provider.wordnet.kwi.compact

import treebolic.model.Model
import treebolic.model.MutableEdge
import treebolic.model.MutableNode
import treebolic.provider.wordnet.kwi.ImageFactory
import java.net.URL
import java.util.Properties

/**
 * Provider for WordNet
 *
 * @author Bernard Bou
 */
class Provider2 : Provider() {

    init {
        membersLoadBalancer.setGroupNode(null, wordsBackgroundColor, wordsForegroundColor, wordsEdgeColor, LOADBALANCING_EDGE_STYLE, ImageIndex.WORDS.ordinal, null, null)
        semRelationsLoadBalancer.setGroupNode(null, relationsBackgroundColor, relationsForegroundColor, relationsEdgeColor, LOADBALANCING_EDGE_STYLE, ImageIndex.SYNSET.ordinal, null, null)
    }

    // I N T E R F A C E

    override fun makeModel(source: String, base: URL, parameters: Properties): Model? {
        val model = super.makeModel(source, base, parameters)
        return if (model == null) null else Model(model.tree, model.settings, ImageFactory.images)
    }

    // I M A G E

    override fun setNodeImage(node: MutableNode, index: Int) {
        if (index != -1) {
            node.image = ImageFactory.images[index]
        }
    }

    override fun setTreeEdgeImage(node: MutableNode, index: Int) {
        if (index != -1) {
            node.edgeImage = ImageFactory.images[index]
        }
    }

    override fun setEdgeImage(edge: MutableEdge, index: Int) {
        if (index != -1) {
            edge.image = ImageFactory.images[index]
        }
    }
}
