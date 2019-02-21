#!/bin/bash

testvar="";

testvar+=" fun";
testvar+=" stuff";
testvar+=" and";
testvar+=" things";

echo $testvar;



function crazytrain {
  testvar+=" train train train";
  echo $testvar;
}

crazytrain;
