function run_cockpit() {
    cd $WORKSPACE/cockpit-frontend;
    gulp ; gulp serve
}

function run_modelador() {
    cd $WORKSPACE/modelador-frontend;
    npm run build:dev ;
    npm start
}