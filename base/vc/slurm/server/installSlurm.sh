PMIX_DIR='/usr/local/pmix/2.1.1/'
PMIX_SHA=`(find $PMIX_DIR-type f -print0  | sort -z | xargs -0 sha1sum;
find $PMIX_DIR \( -type f -o -type d \) -print0 | \
 sort -z | xargs -0 stat -c '%n %a') | sha1sum`




if [ ! -d "/usr/local/pmix/2.1.1/" ];
then
  wget https://github.com/pmix/pmix/archive/v2.1.1.tar.gz && tar -xzvf v2.1.1.tar.gz &
  PMIX_PID=$!
  wget https://github.com/SchedMD/slurm/archive/slurm-17-11-5-1.tar.gz && tar -xzvf slurm-17-11-5-1.tar.gz &
  SLURM_PID=$!
  wget https://github.com/open-mpi/ompi/archive/v3.1.0.tar.gz tar -xzvf v3.1.0.tar.gz &
  OMPI_PID=$!

  wait $PMIX_PID
  rm -f v2.1.1.tar.gz &
  cd pmix-2.1.1 && ./autogen.sh
  cd pmix-2.1.1 && ./configure --prefix=/usr/local/pmix/2.1.1/
  cd pmix-2.1.1 && make -j40 all
  cd pmix-2.1.1 && make -j40 install
  rm -rf pmix-2.1.1 &

  wait $SLURM_PID
  rm -f slurm-17-11-5-1.tar.gz &
  cd slurm-slurm-17-11-5-1 && ./configure --prefix=/usr/local/slurm/17.11.5.1/ --with-pmix=/usr/local/pmix/2.1.1/
  cd slurm-slurm-17-11-5-1 && make -j40 all
  cd slurm-slurm-17-11-5-1 && make -j40 install
  rm -rf slurm-slurm-17-11-5-1 &

  wait $OMPI_PID)
  rm -f v3.1.0.tar.gz &
  cd ompi-3.1.0 && ./autogen.pl
  cd ompi-3.1.0 && ./configure --prefix=/usr/local/ompi/3.1.0/ --with-libevent=/usr --with-pmix=/usr/local/pmix/2.1.1/ --with-slurm
  cd ompi-3.1.0 && make -j40 all
  cd ompi-3.1.0 && make -j40 install
  rm -rf ompi-3.1.0 &

  wait
fi
