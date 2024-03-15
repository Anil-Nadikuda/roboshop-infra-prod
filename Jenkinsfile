pipeline {
    agent {
        node {
            label 'AGENT-1'
        }
    }
    // environment {
    //     packageVersion = ''
    //     nexusURL = '172.31.83.22:8081'
    // }
    options {
        // timeout(time: 1, unit: 'HOURS')
        // disableConcurrentBuilds()
        ansiColor('xterm')
    }
    parameters {
    

        booleanParam(name: 'Deploy', defaultValue: false, description: 'Toggle this value')

        // choice(name: 'CHOICE', choices: ['One', 'Two', 'Three'], description: 'Pick something')

        // password(name: 'PASSWORD', defaultValue: 'SECRET', description: 'Enter a password')
    }
    stages {
        stage('VPC') {
            steps {
                 sh """
                 cd 01-vpc
                 terraform init -reconfigure
                 terraform apply -auto-approve
                 """
            }
        }
        stage('SG') {
            steps {
                 sh """
                 cd 02-sg
                 terraform init -reconfigure
                 terraform apply -auto-approve
                 """
            }
        }
        stage('VPN') {
            steps {
                 sh """
                 cd 03-vpn
                 terraform init -reconfigure
                 terraform apply -auto-approve
                 """
            }
        }
        stage('DB ALB') {
            parallel {
                stage('DB') {
                    steps {
                        sh """
                        cd 04-databases
                        terraform init -reconfigure
                        terraform apply -auto-approve
                        """
                    }
                }
                // stage('ALB') {
                //     steps {
                //         sh """
                //         cd 05-app-alb
                //         terraform init -reconfigure
                //         terraform apply -auto-approve
                //         """
                //     }
                // }
            }
        }
        
        // destrpyyyy remove 
        stage('Destroy all') {
            steps {
                 sh """
                 cd 05-app-alb
                 terraform init -reconfigure
                 terraform destroy -auto-approve
                 cd ..
                 cd 04-databases
                 terraform destroy -auto-approve
                 cd ..
                 cd 03-vpn
                 terraform destroy -auto-approve
                 cd ..
                 cd 02-sg
                 terraform destroy -auto-approve
                 cd ..
                 cd 01-vpc
                 terraform destroy -auto-approve
                 """
            }
        }
    }

    // post build
    post { 
        always { 
            echo 'I will always say Hello again!'
            deleteDir()
        }
        failure { 
            echo 'this runs when pipeline is failed, used generally to send some alerts'
        }
        success{
            echo 'I will say Hello when pipeline is success'
        }
    }
}