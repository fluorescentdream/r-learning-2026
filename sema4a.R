counts <- read.table("C:/Users/Ramana Lingala/Downloads/TARGET-seq_raw_counts_matrix.txt.gz", sep="\t", header=TRUE, row.names=1)
dim(counts)
metadata <- read.table("C:/Users/Ramana Lingala/Downloads/TARGET-seq_metadata.tsv", sep="\t", header=TRUE)
dim(metadata)
colnames(metadata)
metadata$Cell <- gsub("-", ".", metadata$Cell)
colnames(counts)[1:5]
metadata$Cell[1:5]

#align metadata to counts
metadata <- metadata[match(colnames(counts), metadata$Cell), ]

#a vector of expression values for sema4a across ALL cells
#sema4a: cell1 (value), cell2 (value), cell3 (value) ....
#still matrix/df like; convert to numeric to align
sema4a <- as.numeric(counts["SEMA4A", ])

#create sema4a column in metadata
metadata$SEMA4A <- sema4a

summary(metadata$SEMA4A)

#compare sema4a expr across genotypes in metadata table
#margin more wide
par(mar = c(10, 4, 2, 1))
boxplot(SEMA4A ~ Genotype, data=metadata,  las = 2, cex.axis = 0.7)
table(metadata$Genotype)
