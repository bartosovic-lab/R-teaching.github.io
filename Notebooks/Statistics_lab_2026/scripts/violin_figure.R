# Instructor figure. Students receive the PNG and can skip ggplot2 installation.
small <- read.csv("data/mmse_small.csv")
small$Group <- factor(small$Group, levels = c("Control", "AD"))
library(ggplot2)
violin <- ggplot(small, aes(x = Group, y = MMSE, fill = Group)) +
  geom_violin(trim = TRUE, scale = "width", alpha = 0.5) +
  geom_boxplot(width = 0.12, outlier.shape = NA) +
  geom_point(position = position_jitter(width = 0.08, height = 0, seed = 7)) +
  scale_fill_manual(values = c("lightblue", "peachpuff")) +
  labs(x = NULL, y = "MMSE score (points)") +
  theme_classic(base_size = 14) +
  theme(legend.position = "none")
ggsave("figures/mmse_violin.png", violin, width = 7, height = 4.5, dpi = 150)
