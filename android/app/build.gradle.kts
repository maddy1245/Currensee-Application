plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin") // Flutter plugin must be applied last
}

android {
    namespace = "me.carda.awesome_notifications"
    compileSdk = 34 // Flutter latest stable SDK version

    defaultConfig {
        applicationId = "com.example.myapp"
        minSdk = 21 // Flutter default minSdkVersion
        targetSdk = 34 // Flutter default targetSdkVersion
        versionCode = 1
        versionName = "1.0"
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    buildTypes {
        release {
            isMinifyEnabled = true 
            isShrinkResources = true
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
            signingConfig = signingConfigs.getByName("debug") // Change this for production ke liye
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib:1.8.22") // Updated Kotlin StdLib version
}
