#!/bin/bash

PMIX_DIR='/opt/pmix/2.1.1/'
SLURM_DIR='/opt/slurm/17.11.5.1/'
OMPI_DIR='/opt/openmpi/3.1.0/'

set -e

CURRDIR='/tmp'
cd $CURRDIR

if [ ! -d $OMPI_DIR ];
then
   tar -xzvf v2.1.1.tar.gz &
  PMIX_PID=$!

  wait $PMIX_PID
  rm -f v2.1.1.tar.gz &
  tar -xzvf slurm-17-11-5-1.tar.gz &
  SLURM_PID=$!
  cd pmix-2.1.1
  ./autogen.sh
  ./configure --prefix=$PMIX_DIR
  make -j40 all
  make -j40 install
  cd $CURRDIR
  rm -rf pmix-2.1.1 &

  wait $SLURM_PID
  rm -f slurm-17-11-5-1.tar.gz &
  tar -xzvf v3.1.0.tar.gz &
  OMPI_PID=$!
  cd slurm-slurm-17-11-5-1
  ./configure --prefix=$SLURM_DIR --with-pmix=$PMIX_DIR
  make -j40 all
  make -j40 install
  cd $CURRDIR
  rm -rf slurm-slurm-17-11-5-1 &

  wait $OMPI_PID
  rm -f v3.1.0.tar.gz &
  cd ompi-3.1.0
  ./autogen.pl
  ./configure --prefix=$OMPI_DIR --with-libevent=/usr --with-pmix=$PMIX_DIR --with-slurm
  make -j40 all
  make -j40 install
  cd $CURRDIR
  rm -rf ompi-3.1.0 &

  wait
fi
