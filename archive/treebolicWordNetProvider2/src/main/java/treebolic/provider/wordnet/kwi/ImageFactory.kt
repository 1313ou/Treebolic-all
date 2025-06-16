/*
 * Copyright (c) 2019-2023. Bernard Bou
 */
package treebolic.provider.wordnet.kwi

import treebolic.glue.iface.Image

/**
 * Image factory for WordNet
 *
 * @author Bernard Bou
 */
object ImageFactory {

    /**
     * ImageFactory
     *
     * @param imageUrls image urls
     * @return images
     */
    private fun makeImages(imageUrls: Array<String>): Array<Image?> {
        val images = arrayOfNulls<Image>(imageUrls.size)
        for (i in imageUrls.indices) {
            images[i] = treebolic.glue.Image(ImageFactory::class.java.getResource("images/" + imageUrls[i]))
        }
        return images
    }

    // D E C O R A T I O N   M E M B E R S

    /**
     * Images
     */
    @JvmField
    val images: Array<Image?> = makeImages(BaseProvider.images)
}
