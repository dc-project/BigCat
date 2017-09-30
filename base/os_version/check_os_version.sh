#!/bin/bash

set -err

if [ -f "/etc/os-release" ];then
    RELEASE_INFO=$(cat /etc/os-release | grep "^VERSION=" | awk -F '="' '{print $2}' | awk '{print $1}' | cut -b 1-5)
    if [[ $RELEASE_INFO == "7" ]];then
        RELEASE_Type='centos/7'
    elif [[ $RELEASE_INFO =~ "14" ]];then
        RELEASE_Type='ubuntu/trusty'
    elif [[ $RELEASE_INFO =~ "16" ]];then
        RELEASE_Type='ubuntu/xenial'
    elif [[ $RELEASE_INFO =~ "9" ]];then
        RELEASE_Type="debian/9"
    else
        if [[ "$(uname)" == "Darwin" ]];then
            RELEASE_Type="darwin"
        else
            echo "Release $(cat /etc/os-release | grep "PRETTY" | awk -F '"' '{print $2}') Not supported"
            exit 1
        fi
    fi
else
    if [[ "$(uname)" == "Darwin" ]];then
            RELEASE_Type="darwin"
    else
            echo "Release $(uname) Not supported"
            exit 1
    fi
fi


echo $RELEASE_Type