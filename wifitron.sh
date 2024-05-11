read -p "Enter SSID: " S
read -p "Enter password: " P
qrencode -o w.png "WIFI:T:WPA;S:${S};P:${P};;"
magick w.png -scale 200% w.png
echo "
\![](w.png)

**\`${S}\`**

\`${P}\`
" | pandoc -o w.pdf
