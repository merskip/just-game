pipeline {
    agent any

    environment {
        EXPORT_TEMPLATE = 'Web'
        BUILD_DIR = 'Build/Web'
    }

    stages {
        stage('Download Godot') {
            steps {
                echo 'Pobieranie archiwum Godot...'
                sh 'wget https://github.com/godotengine/godot/releases/download/4.3-stable/Godot_v4.3-stable_linux.x86_64.zip -O Godot_v4.3-stable_linux.x86_64.zip'
                sh 'unzip Godot_v4.3-stable_linux.x86_64.zip'
                sh 'chmod +x Godot_v4.3-stable_linux.x86_64'
            }
        }

        stage('Build') {
            steps {
                echo "Budowanie gry w schemacie ${EXPORT_TEMPLATE}..."
                sh "./Godot_v4.3-stable_linux.x86_64 --export-release $EXPORT_TEMPLATE $BUILD_DIR"
            }
        }
    }

    post {
        cleanup {
            echo 'Czyszczenie plików tymczasowych...'
            sh 'rm -f Godot_v4.3-stable_linux.x86_64.zip'
            sh 'rm -f Godot_v4.3-stable_linux.x86_64'
        }
    }
}
