# исходные данные
motifs2 <- matrix(c(
  "a", "C", "g", "G", "T", "A", "A", "t", "t", "C", "a", "G",
  "t", "G", "G", "G", "C", "A", "A", "T", "t", "C", "C", "a",
  "A", "C", "G", "t", "t", "A", "A", "t", "t", "C", "G", "G",
  "T", "G", "C", "G", "G", "G", "A", "t", "t", "C", "C", "C",
  "t", "C", "G", "a", "A", "A", "A", "t", "t", "C", "a", "G",
  "A", "C", "G", "G", "C", "G", "A", "a", "t", "T", "C", "C",
  "T", "C", "G", "t", "G", "A", "A", "t", "t", "a", "C", "G",
  "t", "C", "G", "G", "G", "A", "A", "t", "t", "C", "a", "C",
  "A", "G", "G", "G", "T", "A", "A", "t", "t", "C", "C", "G",
  "t", "C", "G", "G", "A", "A", "A", "a", "t", "C", "a", "C"
), nrow = 10, byrow = TRUE)

# к верхнемум регистру
motifs2_upper <- matrix(toupper(motifs2), nrow = nrow(motifs2), ncol = ncol(motifs2))

# COUNT и PROFILE
NUCS <- c("A", "C", "G", "T")

count_matrix <- apply(
  motifs2_upper,
  2,
  function(col) table(factor(col, levels = NUCS))
)
count_matrix <- as.matrix(count_matrix) 

profile_matrix <- apply(
  motifs2_upper,
  2,
  function(col) {
    counts <- table(factor(col, levels = NUCS))
    counts / sum(counts)
  }
)
profile_matrix <- as.matrix(profile_matrix)

# 4scoreMotifs
scoreMotifs <- function(motifs) {
  mtx <- matrix(toupper(motifs), nrow = nrow(motifs))
  sum(apply(mtx, 2, function(col) length(col) - max(table(col))))
}

motifs2_score <- scoreMotifs(motifs2_upper)

# getConsensus
getConsensus <- function(motifs) {
  mtx <- matrix(toupper(motifs), nrow = nrow(motifs))
  prof <- apply(mtx, 2, function(col) {
    counts <- table(factor(col, levels = NUCS))
    counts / sum(counts)
  })
  prof <- as.matrix(prof)
  consensus_vec <- apply(prof, 2, function(col) NUCS[which.max(col)])
  paste(consensus_vec, collapse = "")
}

motifs2_consensus <- getConsensus(motifs2_upper)

# barplot
col1_counts <- table(factor(motifs2_upper[, 1], levels = NUCS))
barplot(col1_counts,
        col  = "skyblue",
        main = "частоты нуклеотидов в 1-м столбце",
        ylab = "количество",
        xlab = "нуклеотид")

# вывод в консоль
cat("размер:", nrow(motifs2_upper), "x", ncol(motifs2_upper), "\n")
cat("score:", motifs2_score, "\n")
cat("consensus:", motifs2_consensus, "\n")
