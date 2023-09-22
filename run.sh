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

echo "[-] pt2en: GENERATING"
fstconcat compiled/pt2en-part.fst compiled/mix2numerical-part.fst > compiled/pt2en.fst
echo "[+] pt2en: GENERATING"

echo "[-] en2pt: GENERATING"
fstinvert compiled/pt2en.fst > compiled/en2pt.fst
echo "[+] en2pt: DONE"

echo "[+] day: DONE"

echo "[+] month: DONE"

echo "[+] year: DONE"

echo "[-] datenum2text: GENERATING"
fstconcat compiled/month.fst compiled/removeslash.fst > compiled/month-noslash.fst
fstconcat compiled/day.fst compiled/removeslash.fst > compiled/day-noslash.fst
fstconcat compiled/datenum2text-part.fst compiled/year.fst > compiled/datenum2text-part-year.fst
fstconcat compiled/month-noslash.fst compiled/day-noslash.fst > compiled/month-day-noslash.fst
fstconcat compiled/month-day-noslash.fst compiled/datenum2text-part-year.fst > compiled/datenum2text.fst
rm compiled/month-noslash.fst compiled/day-noslash.fst compiled/month-day-noslash.fst compiled/datenum2text-part-year.fst
echo "[+] datenum2text: DONE"

echo "[-] mix2text: GENERATING"
fstcompose compiled/mix2numerical.fst compiled/datenum2text.fst > compiled/mix2text-part2.fst
fstcompose compiled/pt2en.fst compiled/mix2text-part2.fst > compiled/mix2text-part1.fst
fstunion compiled/mix2text-part1.fst compiled/mix2text-part2.fst > compiled/mix2text.fst
rm compiled/mix2text-part1.fst compiled/mix2text-part2.fst
echo "[+] mix2text: DONE"

echo "[-] date2text: GENERATING"
fstunion compiled/mix2text.fst compiled/datenum2text.fst > compiled/date2text.fst
echo "[+] date2text: DONE"

# ############ generate PDFs  ############
echo "Starting to generate PDFs"
for i in compiled/*.fst; do
    echo "Creating image: images/$(basename $i '.fst').pdf"
    fstdraw --portrait --isymbols=syms.txt --osymbols=syms.txt $i | dot -Tpdf > images/$(basename $i '.fst').pdf
done
