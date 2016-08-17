#!/bin/bash

echo "removeing evaluation key"
rm ~/.IntelliJIdea15/config/eval/idea15.evaluation.key

echo "resetting evalsprt in options.xml"
sed -i '/evlsprt/d' ~/.IntelliJIdea15/config/options/options.xml

echo "resetting evalsprt in prefs.xml"
sed -i '/evlsprt/d' ~/.java/.userPrefs/prefs.xml
