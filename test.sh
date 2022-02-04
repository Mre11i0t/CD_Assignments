make -f mkfile.mk
echo 'Valid test 1'
./a.out < lab-1_test-1_valid.c
echo 'Valid test 2'
./a.out < lab-1_test-2_valid.c
echo 'Invalid test 1'
./a.out < lab-1_test-1_invalid.c
echo 'Invalid test 2'
./a.out < lab-1_test-2_invalid.c
echo 'fin.'
