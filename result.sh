#!/bin/bash


tr -d  '\n' < result.txt > result1.txt
sed -i 's/MDL16CS/\nMDL16CS/g' result1.txt
sed -i 's/MDL16CS/MDL16CS /g' result1.txt
sed -i 's/ELECTRONICS/\nELECTRONICS/g' result1.txt
grep -w 'MDL16CS' result1.txt > result5.txt
sed -i 's/MDL16CS /MDL16CS/g' result5.txt

sed -i 's/MA101/ /g;s/PH100//g;s/BE110//g;s/BE10105//g;s/BE103//g;s/EE110//g;s/EE100//g;s/PH110//g;s/CS110//g;' result5.txt

sort -k 6 csb.txt >sortedcsb.txt

join -1 1 -2 6 result5.txt sortedcsb.txt >joinresult.txt

sed -i 's/(O)/10/g;s/(A+)/9/g;s/(A)/8.5/g;s/(B+)/8/g;s/(B)/7/g;s/(C)/6/g;s/(P)/5/g;s/(F)/0/g;' joinresult.txt
sed -i 's/,/ /g' joinresult.txt
awk  '{print $1,(($2*4)+($3*4)+($4*3)+($5*3)+($6*3)+($7*3)+($8)+($9)+($10))/23,$11,$12,$13,$14,$15,$16,$17,$18}' joinresult.txt>GPA.txt



#S2results#


tr -d  '\n' < S2result_MDL.txt > S2result1.txt
sed -i 's/MDL16CS/\nMDL16CS/g' S2result1.txt
sed -i 's/MDL16CS/MDL16CS /g' S2result1.txt
sed -i 's/TCE16CS006/\nTCE16CS006/g' S2result1.txt
grep -w 'MDL16CS' S2result1.txt > S2result5.txt
sed -i 's/MDL16CS /MDL16CS/g' S2result5.txt

sed -i 's/CY100//g;s/BE100//g;s/EC100//g;s/CY110//g;s/EC110//g;s/MA102//g;s/BE102//g;s/CS100//g;s/CS120//g;' S2result5.txt

sort -k 6 csb.txt >sortedcsb.txt

join -1 1 -2 6 S2result5.txt sortedcsb.txt > S2joinresult.txt

sed -i 's/(O)/10/g;s/(A+)/9/g;s/(A)/8.5/g;s/(B+)/8/g;s/(B)/7/g;s/(C)/6/g;s/(P)/5/g;s/(F)/0/g;' S2joinresult.txt
sed -i 's/,/ /g' S2joinresult.txt
awk  '{print $1,(($2*4)+($3*4)+($4*3)+($5*1)+($6*1)+($7*4)+($8*3)+($9*3)+($10))/24,$11,$12,$13,$14,$15,$16,$17,$18}' S2joinresult.txt>S2GPA.txt


paste <(cut -d' ' -f2 GPA.txt) <(cut -d' ' -f2 S2GPA.txt) > Cresult.txt

join -1 1 -2 1 GPA.txt S2GPA.txt > CGPA.txt
awk '{print ($1*23 +$2*24)/47}' Cresult.txt>RealCGPA.txt
paste RealCGPA.txt  <(cut -d ' ' -f1,8,9 GPA.txt)

