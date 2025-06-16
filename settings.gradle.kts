/*
 * Copyright (c) 2024. Bernard Bou <1313ou@gmail.com>
 */

pluginManagement {
    repositories {
        gradlePluginPortal()
        google {
            content {
                includeGroupByRegex("com\\.android.*")
                includeGroupByRegex("com\\.google.*")
                includeGroupByRegex("androidx.*")
            }
        }
        mavenLocal()
        mavenCentral()
    }
}

dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenLocal()
        mavenCentral()
    }
}

// C O R E

include(":treebolicIface")
project(":treebolicIface").projectDir = File("./TreebolicLib/treebolicIface/")

include(":treebolicGlue")
project(":treebolicGlue").projectDir = File("./TreebolicLib/treebolicGlue/")

// L I B S

include(":commonLib")
project(":commonLib").projectDir = File("./TreebolicSupportLibs/commonLib/")

include(":searchLib")
project(":searchLib").projectDir = File("./TreebolicSupportLibs/searchLib/")

include(":wheelLib")
project(":wheelLib").projectDir = File("./TreebolicSupportLibs/wheelLib/")

include(":guideLib")
project(":guideLib").projectDir = File("./TreebolicSupportLibs/guideLib/")

include(":downloadLib")
project(":downloadLib").projectDir = File("./TreebolicSupportLibs/downloadLib/")

include(":colorLib")
project(":colorLib").projectDir = File("./TreebolicSupportLibs/colorLib/")

include(":preferenceLib")
project(":preferenceLib").projectDir = File("./TreebolicSupportLibs/preferenceLib/")

include(":rateLib")
project(":rateLib").projectDir = File("./TreebolicSponsorLibs/rateLib/")

include(":othersLib")
project(":othersLib").projectDir = File("./TreebolicSponsorLibs/othersLib/")

include(":donateLib")
project(":donateLib").projectDir = File("./TreebolicSponsorLibs/donateLib/")

include(":fileChooserLib")
project(":fileChooserLib").projectDir = File("./TreebolicSupportLibs/fileChooserLib/")

include(":storageLib")
project(":storageLib").projectDir = File("./TreebolicSupportLibs/storageLib/")

include(":testLib")
project(":testLib").projectDir = File("./TreebolicSupportLibs/testLib/")

include(":xPreferenceLib")
project(":xPreferenceLib").projectDir = File("./TreebolicWordNet/xPreferenceLib/")

include(":captureLib")
project(":captureLib").projectDir = File("./TreebolicWordNet/captureLib/")

include(":treebolicParcel")
project(":treebolicParcel").projectDir = File("./TreebolicServices/treebolicParcel/")

include(":treebolicSecureLib")
project(":treebolicSecureLib").projectDir = File("./TreebolicPay/treebolicSecureLib/")

include(":treebolicTrialLib")
project(":treebolicTrialLib").projectDir = File("./TreebolicPay/treebolicTrialLib/")

// S T U B S

include(":treebolicOneXml")
project(":treebolicOneXml").projectDir = File("./TreebolicOne/treebolicOneXml/")

include(":treebolicOneOwl")
project(":treebolicOneOwl").projectDir = File("./TreebolicOne/treebolicOneOwl/")

include(":treebolicOneSql")
project(":treebolicOneSql").projectDir = File("./TreebolicOne/treebolicOneSql/")

include(":treebolicXmlTemplate")
project(":treebolicXmlTemplate").projectDir = File("./TreebolicOne/treebolicXmlTemplate/")

include(":treebolicOwlTemplate")
project(":treebolicOwlTemplate").projectDir = File("./TreebolicOne/treebolicOwlTemplate/")

include(":treebolicSqlTemplate")
project(":treebolicSqlTemplate").projectDir = File("./TreebolicOne/treebolicSqlTemplate/")

// S E R V I C E / C L I E N T

include(":treebolicAidl")
project(":treebolicAidl").projectDir = File("./TreebolicServices/treebolicAidl/")

include(":treebolicClientsLib")
project(":treebolicClientsLib").projectDir = File("./TreebolicServices/treebolicClientsLib/")

include(":treebolicClientsIface")
project(":treebolicClientsIface").projectDir = File("./TreebolicServices/treebolicClientsIface/")

include(":treebolicServicesLib")
project(":treebolicServicesLib").projectDir = File("./TreebolicServices/treebolicServicesLib/")

include(":treebolicServicesIface")
project(":treebolicServicesIface").projectDir = File("./TreebolicServices/treebolicServicesIface/")

// P R O V I D E R S

include(":treebolicOwlProvider")
project(":treebolicOwlProvider").projectDir = File("./TreebolicOne/treebolicOwlProvider/")

include(":treebolicSqliteProvider")
project(":treebolicSqliteProvider").projectDir = File("./TreebolicOne/treebolicSqliteProvider/")

include(":treebolicWordNetProvider")
project(":treebolicWordNetProvider").projectDir = File("./TreebolicWordNet/treebolicWordNetProvider/")

include(":treebolicContactsProvider")
project(":treebolicContactsProvider").projectDir = File("./TreebolicContacts/treebolicContactsProvider/")

include(":treebolicFilesProvider")
project(":treebolicFilesProvider").projectDir = File("./TreebolicFiles/treebolicFilesProvider/")

// A P P S

include(":treebolic")
project(":treebolic").projectDir = File("./Treebolic/treebolic/")

include(":treebolicFilesServices")
project(":treebolicFilesServices").projectDir = File("./TreebolicServices/treebolicFilesServices/")

include(":treebolicOwlServices")
project(":treebolicOwlServices").projectDir = File("./TreebolicServices/treebolicOwlServices/")

include(":treebolicWordNetServices")
project(":treebolicWordNetServices").projectDir = File("./TreebolicServices/treebolicWordNetServices/")

include(":treebolicFungi")
project(":treebolicFungi").projectDir = File("./TreebolicFungi/treebolicFungi/")

include(":treebolicSumo")
project(":treebolicSumo").projectDir = File("./TreebolicSumo/treebolicSumo/")

include(":treebolicPlants")
project(":treebolicPlants").projectDir = File("./TreebolicPlants/treebolicPlants/")

include(":treebolicRoyalsLib")
project(":treebolicRoyalsLib").projectDir = File("./TreebolicRoyals/treebolicRoyalsLib/")

include(":treebolicRoyals")
project(":treebolicRoyals").projectDir = File("./TreebolicRoyals/treebolicRoyals/")

include(":treebolicRoyalsTrial")
project(":treebolicRoyalsTrial").projectDir = File("./TreebolicRoyals/treebolicRoyalsTrial/")

include(":treebolicRoyalsIAB")
project(":treebolicRoyalsIAB").projectDir = File("./TreebolicRoyals/treebolicRoyalsIAB/")

include(":treebolicWordNetLib")
project(":treebolicWordNetLib").projectDir = File("./TreebolicWordNet/treebolicWordNetLib/")

include(":treebolicWordNet")
project(":treebolicWordNet").projectDir = File("./TreebolicWordNet/treebolicWordNet/")

include(":treebolicWordNetForGoogle")
project(":treebolicWordNetForGoogle").projectDir = File("./TreebolicWordNet/treebolicWordNetForGoogle/")

include(":treebolicWordNetForAmazon")
project(":treebolicWordNetForAmazon").projectDir = File("./TreebolicWordNet/treebolicWordNetForAmazon/")

include(":treebolicWordNetIAB")
project(":treebolicWordNetIAB").projectDir = File("./TreebolicWordNet/treebolicWordNetIAB/")

include(":treebolicContacts")
project(":treebolicContacts").projectDir = File("./TreebolicContacts/treebolicContacts/")

include(":wordNetProvider")
project(":wordNetProvider").projectDir = File("./TreebolicWordNet/wordNetProvider/")
