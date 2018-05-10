PMIX_DIR='/usr/local/pmix/2.1.1/'
SLURM_DIR='/usr/local/slurm/17.11.5.1/'
OMPI_DIR='/usr/local/ompi/3.1.0/'
#PMIX_SHA=`(find $PMIX_DIR-type f -print0  | sort -z | xargs -0 sha1sum;
#find $PMIX_DIR \( -type f -o -type d \) -print0 | \
# sort -z | xargs -0 stat -c '%n %a') | sha1sum`


set -e

CURRDIR=`pwd`

if [ ! -d $PMIX_DIR ];
then
  wget https://github.com/pmix/pmix/archive/v2.1.1.tar.gz && tar -xzvf v2.1.1.tar.gz #&
#  PMIX_PID=$!

#  wait $PMIX_PID
  wget https://github.com/SchedMD/slurm/archive/slurm-17-11-5-1.tar.gz && tar -xzvf slurm-17-11-5-1.tar.gz #&
#  SLURM_PID=$!
  rm -f v2.1.1.tar.gz #&
  cd pmix-2.1.1
  ./autogen.sh
  ./configure --prefix=$PMIX_DIR
  make -j40 all
  make -j40 install
  cd $CURRDIR
  rm -rf pmix-2.1.1 #&

  wait $SLURM_PID
  wget https://github.com/open-mpi/ompi/archive/v3.1.0.tar.gz && tar -xzvf v3.1.0.tar.gz #&
  OMPI_PID=$!
  rm -f slurm-17-11-5-1.tar.gz #&
  cd slurm-slurm-17-11-5-1
  ./configure --prefix=$SLURM_DIR --with-pmix=$PMIX_DIR
  make -j40 all
  make -j40 install
  cd $CURRDIR
  rm -rf slurm-slurm-17-11-5-1 #&

#  wait $OMPI_PID
  rm -f v3.1.0.tar.gz #&
  cd ompi-3.1.0
  ./autogen.pl
  ./configure --prefix=$OMPI_DIR --with-libevent=/usr --with-pmix=$PMIX_DIR --with-slurm
  make -j40 all
  make -j40 install
  cd $CURRDIR
  rm -rf ompi-3.1.0 #&

#  wait
fi
