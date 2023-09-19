#!/bin/zsh

fst2word() {
    awk '{if(NF>=3){printf("%s",$3)}}END{printf("\n")}'
}

for w in compiled/t-$1-*.fst; do
    symbol_file=./scripts/syms-out.txt
    case "$1" in
        mmm2mm | mix2numerical | pt2en | en2pt)
            symbol_file=./syms.txt
            ;;
    esac

    in=$(cat $w | fstprint --isymbols=./syms.txt | fst2word)
    res=$(fstcompose $w compiled/$1.fst | fstshortestpath | fstproject --project_type=output | fstrmepsilon | fsttopsort | fstprint --acceptor --isymbols=$symbol_file | fst2word)
    echo "$w: $in = $res"
done
