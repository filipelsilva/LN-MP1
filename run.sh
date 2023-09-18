#!/bin/zsh

mkdir -p compiled images

# ############ Compile source transducers ############
for i in sources/*.txt tests/*.txt; do
    echo "Compiling: $i"
    fstcompile --isymbols=syms.txt --osymbols=syms.txt $i | fstarcsort > compiled/$(basename $i ".txt").fst
done

# ############ CORE OF THE PROJECT  ############
echo "Commands for doing the rest of the fsts will be put here"

# ############ generate PDFs  ############
echo "Starting to generate PDFs"
for i in compiled/*.fst; do
    echo "Creating image: images/$(basename $i '.fst').pdf"
    fstdraw --portrait --isymbols=syms.txt --osymbols=syms.txt $i | dot -Tpdf > images/$(basename $i '.fst').pdf
done

# ############ run tests ############

echo "\n***********************************************************"
echo "Testing"
echo "***********************************************************"
for test in sources/*.txt; do
    echo $test
    name_of_test=$(basename $test '.txt')
    for w in compiled/t-${name_of_test}*.fst; do
        fstcompose $w compiled/${name_of_test}.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort > compiled/$(basename $i ".fst")-out.fst
    done
    for i in compiled/t-*-out.fst; do
        echo "Creating image: images/$(basename $i '.fst').pdf"
        fstdraw --portrait --isymbols=syms.txt --osymbols=syms.txt $i | dot -Tpdf > images/$(basename $i '.fst').pdf
    done
done
