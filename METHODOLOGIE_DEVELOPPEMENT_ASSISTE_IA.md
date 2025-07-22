# Processus Standardisé de Développement Assisté par Agent IA (Version Amendée)

## 1. Introduction

Ce document formalise la méthodologie de développement logiciel assisté par un agent IA (tel que GitHub Copilot en mode agent) au sein de l'environnement VS Code. L'objectif est d'établir un processus rigoureux, reproductible et efficace pour garantir la qualité, la maintenabilité et la rapidité du développement.

Ce guide s'appuie sur la synthèse d'une session de développement réussie, transformant une phase exploratoire en une procédure normative. Il met en lumière les interactions optimales entre le développeur (l'Architecte) et l'agent IA (l'Exécutant).

---

## 2. Le Processus de Développement en 4 Phases

### Phase I : Cadrage Stratégique et Initialisation du Socle

Le succès du développement assisté par IA repose sur une phase initiale de cadrage précise, où le développeur agit en tant qu'architecte du système.

*   **Étape 1.1 : Définition de la Vision Architecturale par le Développeur**
    *   Le développeur formalise les objectifs, les contraintes et les principes directeurs dans un **prompt détaillé et structuré**.
    *   *Exemple concret de la session :* Le prompt initial décrivait précisément la structure du design system à créer (`/theme`, `/widgets`), les conventions de nommage (`AppColors`, `AppTextStyles`) et les règles de conception (pas de valeurs en dur).

*   **Étape 1.2 : Délégation de la Création du Socle Technique à l'Agent**
    *   **Rôle de l'Agent IA** : Sur la base du cahier des charges fourni, l'agent est chargé de créer l'arborescence des fichiers et le code de base (boilerplate).
    *   **Actions de l'Agent** :
        *   Création de l'arborescence de dossiers et de fichiers via `create_directory` et `create_file`.
        *   Génération du contenu initial des fichiers de constantes (`app_colors.dart`, `app_theme.dart`) en respectant la norme définie.
    *   **Interaction Efficace** : Un prompt initial exhaustif permet à l'agent de construire une base saine et complète de manière autonome, libérant le développeur pour des tâches à plus haute valeur ajoutée.

### Phase II : Migration et Refactorisation Systématique

Une fois le socle en place, la migration du code existant est orchestrée par le développeur et exécutée de manière chirurgicale par l'agent.

*   **Étape 2.1 : Analyse d'Impact et Plan de Migration**
    *   Le développeur identifie les fichiers à migrer.
    *   **Rôle de l'Agent IA** : L'agent utilise des outils comme `grep_search` ou `semantic_search` pour scanner le projet et lister toutes les instances de code à refactoriser (ex: `Colors.black`, `TextStyle` en ligne, `Padding` avec des valeurs en dur).

*   **Étape 2.2 : Exécution de la Migration Fichier par Fichier**
    *   Le développeur mandate la migration d'un composant ou d'une page spécifique.
    *   **Rôle de l'Agent IA** :
        *   Analyse le fichier cible avec `read_file`.
        *   Applique les modifications en utilisant `replace_string_in_file` ou `apply_patch` pour remplacer systématiquement les anciennes valeurs par les nouvelles constantes du design system.
    *   **Interaction Efficace** : Procéder de manière **itérative et ciblée** (fichier par fichier) permet de valider chaque étape, de maintenir le contrôle sur le processus et de garantir que l'application reste fonctionnelle.

### Phase III : Implémentation et Raffinement de Fonctionnalités

Cette phase illustre la collaboration dynamique entre le développeur et l'agent pour créer ou améliorer une fonctionnalité.

*   **Étape 3.1 : Spécification Fonctionnelle et Visuelle par le Développeur**
    *   Le développeur décrit le comportement et l'apparence souhaités en utilisant un langage qualitatif et descriptif.
    *   *Exemple concret de la session :* "Je veux une animation saccadée, mais adoucie, avec un léger rebond pour marquer le temps."

*   **Étape 3.2 : Génération et Itération Assistées par l'Agent**
    *   **Rôle de l'Agent IA** :
        *   **Génération de la V1** : Propose une première implémentation technique (ex: `TweenSequence`).
        *   **Raffinement Itératif** : Intègre le feedback qualitatif du développeur ("c'est encore trop saccadé") et utilise le contexte fourni ("fais-le plus lisse, comme dans `breathing_animation.dart`") pour converger vers une solution optimale.
    *   **Interaction Efficace** : Le feedback le plus puissant combine une description qualitative du problème avec une **référence à un exemple existant dans le code**. Cela permet à l'agent de comprendre non seulement le "quoi" mais aussi le "comment".

### Phase IV : Débogage Assisté et Stabilisation

En cas d'erreur, l'agent devient un partenaire de débogage de premier plan.

*   **Étape 4.1 : Fourniture du Contexte d'Erreur par le Développeur**
    *   Le développeur fournit à l'agent la **trace d'erreur complète et non tronquée** (stack trace).

*   **Étape 4.2 : Diagnostic, Proposition et Application du Correctif par l'Agent**
    *   **Rôle de l'Agent IA** :
        *   Analyse la trace pour identifier la cause racine et le fichier concerné.
        *   Propose une modification de code ciblée pour corriger le problème.
        *   *Exemple concret de la session :* L'agent a identifié que le calcul du rebond pouvait produire une valeur hors de l'intervalle [0, 1] et l'a remplacé par une fonction `cos` mathématiquement stable.
        *   Applique le correctif via un patch.
    *   **Interaction Efficace** : La fourniture d'un contexte d'erreur complet et précis est le moyen le plus rapide de permettre à l'agent de résoudre un bug.

---

## 3. Bonnes Pratiques d'Interaction avec l'Agent IA

*   **Principe de "l'Architecte et de l'Exécutant"** : Le développeur définit la stratégie, l'architecture et les objectifs (`le quoi` et `le pourquoi`). L'agent exécute les tâches de génération, de refactorisation et de débogage (`le comment`).
*   **Prompts Structurés pour les Tâches Complexes** : Pour initier un projet ou une refactorisation majeure, un cahier des charges détaillé est plus efficace qu'une série de petites requêtes.
*   **Feedback Qualitatif et Contextualisé** : Pour le raffinement, privilégier un dialogue descriptif ("c'est trop lent", "je veux un effet plus organique") et s'appuyer sur des exemples concrets dans le code.
*   **Délégation des Tâches Répétitives** : Utiliser l'agent pour les tâches à faible valeur ajoutée mais chronophages (création de boilerplate, recherche et remplacement, formatage).
*   **Validation Humaine Systématique** : Le développeur reste le garant final de la qualité. Chaque modification proposée par l'agent doit être revue et validée.
