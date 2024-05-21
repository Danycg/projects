pandoc -V lang=es -V geometry:a4paper -V geometry:margin=1in -f markdown --dpi=120 -t pdf ip_elastica.md -o elastica.pdf
pandoc -V lang=es -V geometry:a4paper -V geometry:margin=1in -f markdown --dpi=120 -t pdf servidor.md -o servidor.pdf
pandoc -V lang=es -V geometry:a4paper -V geometry:margin=1in -f markdown --dpi=120 -t pdf ejercicio.md -o ejercicio.pdf
