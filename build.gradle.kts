/*
 * Copyright (c) 2024. Bernard Bou <1313ou@gmail.com>
 */

// Top-level build file where you can add configuration options common to all sub-projects/modules.

buildscript {

    repositories {
        mavenCentral()
        mavenLocal()
        google()
        maven(url = System.getenv("HOME") + "/.m2/repository/")
    }
}

allprojects {

    ext {
        set("versionCode", 119)
        set("versionName", "6.119")
        set("minSdk", 21)
        set("targetSdk", 36)
        set("compileSdk", 36)
    }

    gradle.projectsEvaluated {
        tasks.withType<JavaCompile> {
            options.compilerArgs.addAll(arrayOf("-Xlint:deprecation", "-Xlint:unchecked"))
        }
    }
}

plugins {
    // id("idea")
    alias(libs.plugins.androidApplication) apply false
    alias(libs.plugins.androidLibrary) apply false
    alias(libs.plugins.kotlinAndroid) apply false
}
