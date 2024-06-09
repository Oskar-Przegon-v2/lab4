#!/bin/bash

show_help() {
    echo "Dostepne opcje::"
    echo "--date, -d        Pokazuje dzisiejsza date"
    echo "--logs, -l [N]    Tworzy N plikow log (domyslnie: 100)"
    echo "--help, -h        Pokazuje pomoc"
    echo "--init            Klonuje repozytorium i ustawia PATH"
    echo "--error, -e [N]   Tworzy N plikow error (domyslnie: 100)"

}

create_logs() {
    num_files=${1:-100}
    for i in $(seq 1 $num_files)
    do
        filename="log$i.txt"
        echo "Filename: $filename" > $filename
        echo "Script: $0" >> $filename
        echo "Date: $(date)" >> $filename
    done
}

init_repo() {
    git clone $(git remote get-url origin) cloned_repo
    export PATH=$PATH:$(pwd)/cloned_repo
}

create_errors() {
    num_files=${1:-100}
    mkdir -p errorx
    for i in $(seq 1 $num_files)
    do
        filename="errorx/error$i.txt"
        echo "Filename: $filename" > $filename
        echo "Script: $0" >> $filename
        echo "Date: $(date)" >> $filename
    done
}

case "$1" in
    --date|-d)
        date
        ;;
    --logs|-l)
        create_logs $2
        ;;
    --help|-h)
        show_help
        ;;
    --init)
        init_repo
        ;;
    --error|-e)
        create_errors $2
        ;;
    *)
        show_help
        ;;
esac

