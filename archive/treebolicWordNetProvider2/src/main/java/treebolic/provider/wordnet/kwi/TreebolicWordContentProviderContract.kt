package treebolic.provider.wordnet.kwi

import android.app.SearchManager
import treebolic.provider.wordnet.kwi.BaseProvider
import java.util.Properties

object TreebolicWordContentProviderContract {

    private const val CONFIG_KEY = "wordnet_words_authority"

    /** @noinspection WeakerAccess
     */
    @JvmStatic
    fun makeAuthority(): String {
        try {
            val `is` = BaseProvider::class.java.getResourceAsStream("/org/treebolic/wordnet/config.properties")
            val properties = Properties()
            properties.load(`is`)

            val authority = properties.getProperty(CONFIG_KEY)
            if (authority != null && authority.isNotEmpty()) {
                return authority
            }
            throw RuntimeException("Null provider key=$CONFIG_KEY")
        } catch (e: Exception) {
            throw RuntimeException(e)
        }
    }

    interface SuggestWords {
        companion object {

            // val SEARCH_WORD_PATH = "suggest_word"
            const val URI: String =  /*SEARCH_WORD_PATH + "/" + */SearchManager.SUGGEST_URI_PATH_QUERY
        }
    }
}
