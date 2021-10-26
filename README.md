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
mkdir fastqc multiqc
fastqc -o fastqc/ data/*
multiqc ./fastqc/ -o multiqc/
```
<!-- здесь нужно вставить результаты -->

3. Обрезка чтений
```bash
# TODO
```

...
