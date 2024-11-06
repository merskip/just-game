pipeline {
    agent any

    environment {
        XDG_CACHE_HOME = "${WORKSPACE}/.cache"
        XDG_DATA_HOME = "${WORKSPACE}./.data"
        XDG_CONFIG_HOME = "${WORKSPACE}./.config"
        EXPORT_TEMPLATE = 'Web'
        BUILD_DIR = "${WORKSPACE}/Build/Web"
        GODOT_BINARY = "Godot_v4.3-stable_linux.x86_64"
    }

    stages {
        stage('Download Godot') {
            steps {
                sh 'wget -nv https://github.com/godotengine/godot/releases/download/4.3-stable/Godot_v4.3-stable_linux.x86_64.zip -O Godot_v4.3-stable_linux.x86_64.zip'
                sh 'unzip Godot_v4.3-stable_linux.x86_64.zip'
                sh "chmod +x $GODOT_BINARY"
            }
        }

        stage('Build') {
            steps {
                sh "./$GODOT_BINARY --verbose --editor --headless --import"
                sh "./$GODOT_BINARY --verbose --headless --export-release $EXPORT_TEMPLATE $BUILD_DIR"
            }
        }
    }

    post {
        cleanup {
            sh 'rm -f Godot_v4.3-stable_linux.x86_64.zip'
            sh "rm -f $GODOT_BINARY"
        }
    }
}
