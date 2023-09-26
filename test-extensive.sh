#!/bin/zsh

fst2word() {
    awk '{if(NF>=3){printf("%s",$3)}}END{printf("\n")}'
}

run_test() {
    res=$(python3 ./scripts/word2fst.py "$2" | fstcompile --isymbols=syms.txt --osymbols=syms.txt | fstarcsort | fstcompose - compiled/$1.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=$symbol_file | fst2word)
    echo "$2 = $res"
}

months_mmm_pt=( JAN FEV MAR ABR MAI JUN JUL AGO SET OUT NOV DEZ )
months_mmm_en=( JAN FEB MAR APR MAY JUN JUL AUG SEP OCT NOV DEC )
numbers_with_0=({01..09})
months_mm_no0=({1..12})
days_no0=({1..31})
years=({2001..2099})

symbol_file=./scripts/syms-out.txt

test=$1
case "$test" in
    mmm2mm | mix2numerical | pt2en | en2pt)
        symbol_file=./syms.txt
        ;;
esac

# "${packages[@]}"
case "$test" in
    mmm2mm)
        for m in ${months_mmm_en[@]}; do
            run_test $test $m
        done
        ;;
    mix2numerical)
        for m in ${months_mmm_en[@]}; do
            run_test $test "$m/01/2056"
            run_test $test "$m/1/2056"
        done
        ;;
    pt2en)
        for m in ${months_mmm_en[@]}; do
            run_test $test "$m/01/2056"
            run_test $test "$m/1/2056"
        done
        for m in ${months_mmm_pt[@]}; do
            run_test $test "$m/01/2056"
            run_test $test "$m/1/2056"
        done
        ;;
    en2pt)
        for m in ${months_mmm_pt[@]}; do
            run_test $test "$m/01/2056"
            run_test $test "$m/1/2056"
        done
        for m in ${months_mmm_en[@]}; do
            run_test $test "$m/01/2056"
            run_test $test "$m/1/2056"
        done
        ;;
    day)
        for d in ${numbers_with_0[@]}; do
            run_test $test "$d"
        done
        for d in ${days_no0[@]}; do
            run_test $test "$d"
        done
        ;;
    month)
        for m in ${months_mm_no0[@]}; do
            run_test $test "$m"
        done
        for m in ${numbers_with_0[@]}; do
            run_test $test "$m"
        done
        ;;
    year)
        for y in ${years[@]}; do
            run_test $test "$y"
        done
        ;;
    datenum2text)
        for m in ${numbers_with_0[@]}; do
            for d in ${days_no0[@]}; do
                run_test $test "$m/$d/2056"
            done
            for d in ${numbers_with_0[@]}; do
                run_test $test "$m/$d/2056"
            done
        done
        for m in ${months_mm_no0[@]}; do
            for d in ${days_no0[@]}; do
                run_test $test "$m/$d/2056"
            done
            for d in ${numbers_with_0[@]}; do
                run_test $test "$m/$d/2056"
            done
        done
        ;;
    mix2text)
        for m in ${months_mmm_pt[@]}; do
            for d in ${numbers_with_0[@]}; do
                run_test $test "$m/$d/2056"
            done
            for d in ${days_no0[@]}; do
                run_test $test "$m/$d/2056"
            done
        done
        for m in ${months_mmm_en[@]}; do
            for d in ${numbers_with_0[@]}; do
                run_test $test "$m/$d/2056"
            done
            for d in ${days_no0[@]}; do
                run_test $test "$m/$d/2056"
            done
        done
        ;;
    date2text)
        for m in ${months_mmm_pt[@]}; do
            for d in ${numbers_with_0[@]}; do
                run_test $test "$m/$d/2056"
            done
            for d in ${days_no0[@]}; do
                run_test $test "$m/$d/2056"
            done
        done
        for m in ${months_mmm_en[@]}; do
            for d in ${numbers_with_0[@]}; do
                run_test $test "$m/$d/2056"
            done
            for d in ${days_no0[@]}; do
                run_test $test "$m/$d/2056"
            done
        done
        for m in ${numbers_with_0[@]}; do
            for d in ${days_no0[@]}; do
                run_test $test "$m/$d/2056"
            done
            for d in ${numbers_with_0[@]}; do
                run_test $test "$m/$d/2056"
            done
        done
        for m in ${months_mm_no0[@]}; do
            for d in ${days_no0[@]}; do
                run_test $test "$m/$d/2056"
            done
            for d in ${numbers_with_0[@]}; do
                run_test $test "$m/$d/2056"
            done
        done
        ;;
esac
