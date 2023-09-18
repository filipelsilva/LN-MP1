#!/bin/zsh

mkdir -p compiled images

# ############ Compile source transducers ############
for i in sources/*.txt tests/*.txt; do
    echo "Compiling: $i"
    fstcompile --isymbols=syms.txt --osymbols=syms.txt $i | fstarcsort > compiled/$(basename $i ".txt").fst
done

# ############ CORE OF THE PROJECT  ############
echo "Taking care of the FSTs"

echo "[+] mmm2mm: DONE"

echo "[-] mix2numerical: GENERATING"
fstconcat compiled/mmm2mm.fst compiled/mix2numerical-part.fst > compiled/mix2numerical.fst
echo "[+] mix2numerical: DONE"

echo "[+] pt2en: DONE"

echo "[-] en2pt: GENERATING"
fstinvert compiled/pt2en.fst > compiled/en2pt.fst
echo "[+] en2pt: DONE"

echo "[+] day: DONE"

echo "[+] month: DONE"

echo "[+] year: DONE"

echo "[-] datenum2text: GENERATING"
fstconcat compiled/month.fst compiled/day.fst > compiled/month-day.fst
fstconcat compiled/datenum2text-part.fst compiled/year.fst > compiled/datenum2text-part-year.fst
fstconcat compiled/month-day.fst compiled/datenum2text-part-year.fst > compiled/datenum2text.fst
rm compiled/month-day.fst compiled/datenum2text-part-year.fst
echo "[+] datenum2text: DONE"

echo "[-] mix2text: TODO"

echo "[-] date2text: TODO"

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
for test in "$(find compiled -type f -not -name 't-*')"; do
    echo $test
    name_of_test=$(basename $test '.fst')
    for w in compiled/t-${name_of_test}*.fst; do
        fstcompose $w compiled/${name_of_test}.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort > compiled/$(basename $i ".fst")-out.fst
    done
    for i in compiled/t-*-out.fst; do
        echo "Creating image: images/$(basename $i '.fst').pdf"
        fstdraw --portrait --isymbols=syms.txt --osymbols=syms.txt $i | dot -Tpdf > images/$(basename $i '.fst').pdf
    done
done
