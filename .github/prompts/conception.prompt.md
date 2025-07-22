---
mode: agent
---

# Tâche : Conception technique détaillée à partir de l’audit craftmanship

## Objectif
Traduire les recommandations issues de l’audit craftmanship en une conception technique détaillée, exploitable directement par un agent pour une implémentation progressive, modulaire et conforme aux standards du projet.

## Contexte
- Projet Flutter avec design system centralisé (`AppColors`, `AppTextStyles`, `AppSpacing`, etc.)
- Architecture modulaire, widgets métiers factorisés, animations isolées
- Audit craftmanship réalisé, rapport disponible avec priorisation des axes d’amélioration

## Exigences

- **Reprendre chaque recommandation priorisée de l’audit**
  - Détailler pour chacune : le besoin, la solution technique, les fichiers/structures à créer ou modifier
  - Proposer une séquence d’implémentation (étape par étape)
  - Préciser les patterns, conventions et outils à utiliser (tests, i18n, breakpoints, etc.)

- **Formuler la conception comme un prompt structuré**
  - Utiliser des titres, des listes à puces, des blocs de code si nécessaire
  - Être explicite sur les attentes de résultat pour chaque étape

- **Contraintes**
  - Respecter l’architecture et le design system existants
  - Ne pas dupliquer ce qui existe déjà, mais compléter ou refactorer si besoin
  - Garantir la maintenabilité, la testabilité et l’évolutivité

## Critères de succès

- Prompt structuré, séquentiel et actionnable par un agent
- Chaque recommandation de l’audit est traduite en tâches techniques concrètes
- La conception est exhaustive, claire et immédiatement exploitable

---

Merci de générer la conception technique détaillée à partir du rapport d’audit craftmanship, sous forme de prompt prêt à l’implémentation par un agent.