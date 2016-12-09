mvn_archtype_bce() {
  mvn_archtype com.airhacks javaee-bce-archetype 0.0.4.1
}

mvn_archtype_jee() {
  mvn_archtype com.airhacks javaee7-essentials-archetype 1.3
}

mvn_archtype() {
  mvn archetype:generate -DarchetypeGroupId=$1 -DarchetypeArtifactId=$2 -DarchetypeVersion=$3
}
