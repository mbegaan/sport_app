---
mode: agent
---

# Tâche : Audit Craftmanship Code Flutter

## Objectif
Réaliser un audit approfondi du code du projet Flutter afin d’évaluer la qualité craftmanship, la maintenabilité, la clarté architecturale et la conformité aux bonnes pratiques modernes.

## Exigences et critères d’audit

- **Lisibilité & clarté**
  - Code auto-explicite, noms explicites, absence de complexité inutile
  - Commentaires pertinents uniquement là où la logique n’est pas triviale

- **Architecture & modularité**
  - Respect du Single Responsibility Principle (SRP)
  - Séparation claire des couches (UI, logique, data, thème, widgets réutilisables)
  - Utilisation cohérente du design system (AppColors, AppTextStyles, AppSpacing, etc.)

- **Réutilisabilité & DRY**
  - Pas de duplication de logique ou de styles
  - Extraction des composants réutilisables

- **Testabilité**
  - Présence de tests unitaires et widget
  - Code structuré pour faciliter le test

- **Performance & accessibilité**
  - Utilisation efficace des ressources (pas de rebuilds inutiles, animations optimisées)
  - Respect des guidelines d’accessibilité (tailles, contrastes, cibles tactiles)

- **Conformité Flutter/Dart**
  - Respect des conventions officielles Flutter/Dart
  - Utilisation des outils d’analyse statique (analyzer, linter)

## Contraintes

- L’audit doit être circonstancié : chaque point doit être illustré par des exemples concrets issus du code.
- Les recommandations doivent être actionnables, hiérarchisées (priorité haute/moyenne/faible) et justifiées.
- Proposer des refactorings ou patterns adaptés au contexte du projet (design system, animations, widgets métiers…).

## Critères de succès

- Rapport d’audit structuré, exhaustif et priorisé
- Liste de recommandations claires, prêtes à être appliquées
- Valorisation des points forts et axes d’amélioration

---

Merci de lancer l’audit craftmanship sur l’ensemble du code du projet, en suivant ces critères et en produisant un rapport détaillé et exploitable.