#!/bin/bash

if [[ $1 == "/opt/Insomnia/insomnia" ]];then
	 insomnia --use-angle=vulkan
else
	 $1
fi

