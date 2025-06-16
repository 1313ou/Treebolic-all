/*
 * Copyright (c) 2019-2023. Bernard Bou
 */
package treebolic.provider.wordnet.kwi

import java.io.File
import java.io.IOException
import java.net.MalformedURLException
import java.net.URL

/**
 * Data manager
 *
 * @author Bernard Bou
 */
class AndroidDataManager : BaseDataManager() {

    @Throws(IOException::class)
    override fun getDataDir(sourceData: URL, home: File): File {
        return setup(sourceData, null, home)
    }

    @Throws(IOException::class)
    override fun deploy(sourceData: URL, home: File): File {
        return setup(sourceData, null, home)
    }

    companion object {

        /**
         * Expand zip to dir
         *
         * @param zipUrl              zip file
         * @param zipPathPrefixFilter filter of zip entries
         * @param dataDir             dir
         * @return data dir
         */
        @Throws(IOException::class)
        fun setup(zipUrl: URL, zipPathPrefixFilter: String?, dataDir: File): File {
            // directory
            var unzip = true
            if (dataDir.exists()) {
                unzip = !coreCheck(dataDir)
            } else {
                // create output directory is not exists
                dataDir.mkdirs()
            }

            // unzip
            if (unzip) {
                expand(zipUrl, zipPathPrefixFilter, dataDir)
            }

            // return cache
            return dataDir
        }

        /**
         * Setup internal data
         *
         * @param dataTag zipped resource tag
         * @param dataDir destination data dir
         * @return true if successful
         */
        fun setupInternalData(dataTag: String, dataDir: File): Boolean {
            try {
                val zipUrl = checkNotNull(getSourceZipURL(dataTag))
                AndroidDataManager().getDataDir(zipUrl, dataDir)
                return true
            } catch (_: Exception) {
                // ignore
            }
            return false
        }

        /**
         * Make source zip url
         *
         * @param dataTag data
         * @return source zip url
         * @throws MalformedURLException malformed url exception
         */
        @JvmStatic
        @Throws(MalformedURLException::class)
        fun getSourceZipURL(dataTag: String?): URL? {
            return DataManager.getSourceZipURL(dataTag)
        }
    }
}
