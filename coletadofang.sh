#!/bin/bash
#
# VARIAVEIS
# ls /dev/serial/by-id/
DISPOSITIVO=usb-Prolific_Technology_Inc._USB-Serial_Controller-if00-port0
DWEET=SUACHAVEDODWEET
#
rm -rf /tmp/coletadodofang.txt
/root/ve.direct.2  --device=/dev/serial/by-id/$DISPOSITIVO --snapshot | egrep 'Voltage|Current|Yield today|Panel power|Panel voltage' 2> /dev/null > /tmp/coletadodofang.txt
mv /tmp/coletadodofang.txt /root/
#
VOLTAGEM1=$(cat /root/coletadodofang.txt | grep 'Voltage' | tail -1 | awk -F " " '{print $2}')
VOLTAGEM2=$(echo $VOLTAGEM1 | sed $'s/[^[:print:]\t]//g')
GERACAO1=$(cat /root/coletadodofang.txt | grep 'Panel power' | tail -1 |awk -F " " '{print $3}')
GERACAO2=$(echo $GERACAO1 | sed $'s/[^[:print:]\t]//g')
fangchumbogeradohoje1=$(cat /root/coletadodofang.txt | grep 'Yield today' | tail -1 | awk -F " " '{print $3}')
fangchumbogeradohoje2=$(echo $fangchumbogeradohoje1 | sed $'s/[^[:print:]\t]//g')
fangchumbopvamperagem1=$(cat /root/coletadodofang.txt | grep 'Current' | tail -1 | awk -F " " '{print $2}')
fangchumbopvamperagem2=$(echo $fangchumbopvamperagem1 | sed $'s/[^[:print:]\t]//g')
fangchumbopvvoltagem1=$(cat /root/coletadodofang.txt | grep 'Panel voltage' | tail -1 | awk -F " " '{print $3}')
fangchumbopvvoltagem2=$(echo $fangchumbopvvoltagem1 | sed $'s/[^[:print:]\t]//g')
#
wget "https://dweet.io/dweet/for/$DWEET?fangchumbovoltagem=$VOLTAGEM2&fangchumbogeracao=$GERACAO2&fangchumbogeradohoje=$fangchumbogeradohoje2" -O /dev/null
rm -rf /root/$DWEET*

