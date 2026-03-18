printf "name: " && read name && printf "n: " && read n && mkdir -p "$name" && for ((i=1;i<=n;i++)); do : > "$name/${name}${i}.txt"; done
