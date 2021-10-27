# hse21_hw1

```bash
mkdir hw1
ln -s /usr/share/data-minor-bioinf/assembly/  hw1/
cd hw1
mkdir data
```

1.  Выбор случайного набора чтений.

```bash
seqtk sample -s1705 assembly/oil_R1.fastq 5000000 > data/R1_sample.fastq
seqtk sample -s1705 assembly/oil_R2.fastq 5000000 > data/R2_sample.fastq
seqtk sample -s1705 assembly/oilMP_S4_L001_R1_001.fastq 1500000 > data/R1_MP_sample.fastq
seqtk sample -s1705 assembly/oilMP_S4_L001_R2_001.fastq 1500000 > data/R2_MP_sample.fastq
```

2. Оценка качества

```bash
mkdir {fast,multi}qc
fastqc -o fastqc/ data/*
multiqc ./fastqc/ -o multiqc/
```
<!-- здесь нужно вставить результаты -->

3. Обрезка чтений
```bash
platanus_trim data/R?_sample.fastq
platanus_internal_trim data/R?_MP_sample.fastq
rm data/*.fastq
```
4. Оценка качества

```bash
mkdir {fast,multi}qc_trimmer
fastqc -o fastqc_trimmed/ data/*
multiqc ./fastqc_trimmed/ -o multiqc_trimmed/
```

<!-- здесь нужно вставить результаты -->

5. Сборка/анализ контигов и скаффолдов

```bash
platanus assemble -f data/R?_sample.fastq.trimmed
platanus scaffold -c out_contig.fa -IP1 data/R{1,2}_sample.fastq.trimmed -OP2 data/R{1,2}_MP_sample.fastq.int_trimmed
rm *.tsv *Bubble.fa
```

<!--
анализ контигов (общее кол-во контигов, их общая длина, длина самого длинного контига, N50)

анализ скаффолдов (общее кол-во скаффолдов, их общая длина, длина самого длинного скаффолда, N50)
-->

6. Уменьшение числа гэпов

```bash
platanus gap_close -c out_scaffold.fa -IP1 data/R{1,2}_sample.fastq.trimmed -OP2 data/R{1,2}_MP_sample.fastq.int_trimmed
rm -r data/
```
<!--
До/после gap_close: Для самого длинного скаффолда посчитать количество гэпов (участков, состоящих из букв NNNN) и их общую длину
-->

7. Результаты сборки
* [Контиги](./data/contigs.fasta)
* [Скаффолды (до уменьшения гэпов)](./data/scaffolds_noClose.fasta)
* [Скаффолды](./data/scaffolds.fasta)
<!--
*  [Самый длинный скаффолд](./data/longest.fasta)
-->
