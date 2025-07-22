---
mode: agent
---

# Tâche : Implémentation séquentielle de la conception technique détaillée

## Objectif
Implémenter, tester et commiter chaque recommandation issue de la conception technique détaillée, en respectant l’ordre de priorité et en garantissant la qualité, la maintenabilité et la traçabilité des évolutions.

## Exigences

- **Pour chaque recommandation de la conception** :
  - Détailler la tâche à réaliser (création, modification, refactoring…)
  - Implémenter la solution dans le code source
  - Écrire ou compléter les tests associés (unitaires, widget…)
  - Vérifier que tous les tests passent (CI locale ou commande `flutter test`)
  - Commiter la modification avec un message explicite et normé (ex : `feat(test): add unit tests for TimerNotifier`)
  - Passer à la recommandation suivante uniquement après validation de la précédente

- **Contraintes**
  - Ne jamais dupliquer ce qui existe déjà
  - Respecter l’architecture, le design system et les conventions du projet
  - Documenter toute évolution structurante dans le fichier approprié (`ARCHITECTURE.md`, `styleguide.md`…)

## Critères de succès

- Chaque recommandation de la conception est traduite en un ou plusieurs commits atomiques, testés et documentés
- L’historique Git reflète la progression séquentielle et la justification de chaque évolution
- L’application reste fonctionnelle et tous les tests sont verts à chaque étape

---

Merci d’implémenter la conception technique détaillée, étape par étape, en respectant ce protocole d’exécution et de validation.