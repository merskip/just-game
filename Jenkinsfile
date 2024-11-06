pipeline {
    agent any

    environment {
        EXPORT_TEMPLATE = 'Web'
        BUILD_DIR = 'Build/Web'
    }

    stages {
        stage('Download Godot') {
            steps {
                sh 'wget https://github.com/godotengine/godot/releases/download/4.3-stable/Godot_v4.3-stable_linux.x86_64.zip -O Godot_v4.3-stable_linux.x86_64.zip'
                sh 'unzip Godot_v4.3-stable_linux.x86_64.zip'
                sh 'chmod +x Godot_v4.3-stable_linux.x86_64'
            }
        }

        stage('Build') {
            steps {
                sh "./Godot_v4.3-stable_linux.x86_64 --verbose --headless --export-release $EXPORT_TEMPLATE $BUILD_DIR"
            }
        }
    }

    post {
        cleanup {
            sh 'rm -f Godot_v4.3-stable_linux.x86_64.zip'
            sh 'rm -f Godot_v4.3-stable_linux.x86_64'
        }
    }
}
