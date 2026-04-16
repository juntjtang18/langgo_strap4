import type { Schema, Attribute } from '@strapi/strapi';

export interface AContentMeta extends Schema.Component {
  collectionName: 'components_u_content_metas';
  info: {
    displayName: 'content_meta';
    icon: 'bulletList';
    description: '';
  };
  attributes: {
    article: Attribute.String;
    gender: Attribute.Enumeration<['masculine', 'feminine', 'neuter']>;
    register: Attribute.String;
    plural_form: Attribute.String;
    part_of_speech: Attribute.String;
    verb_meta: Attribute.Component<'a.verb-meta', true>;
  };
}

export interface AExerciseMeta extends Schema.Component {
  collectionName: 'components_u_exercise_metas';
  info: {
    displayName: 'exercise_meta';
    icon: 'dashboard';
    description: '';
  };
  attributes: {
    base_mcq: Attribute.JSON;
    target_mcq: Attribute.JSON;
  };
}

export interface AGenerationPrompts extends Schema.Component {
  collectionName: 'components_a_generation_prompts';
  info: {
    displayName: 'generation prompts';
    icon: 'bulletList';
  };
  attributes: {
    cover_image_prompt: Attribute.Text;
    brief_video_prompt: Attribute.Text;
    illustration_prompts: Attribute.Component<'a.illustration-prompt', true>;
  };
}

export interface AIllustrationPrompt extends Schema.Component {
  collectionName: 'components_a_illustration_prompts';
  info: {
    displayName: 'illustration prompt';
    icon: 'layer';
  };
  attributes: {
    prompt: Attribute.Text;
  };
}

export interface AIllustrations extends Schema.Component {
  collectionName: 'components_a_illustrations';
  info: {
    displayName: 'illustrations';
    icon: 'picture';
  };
  attributes: {
    caption: Attribute.String;
    alt_text: Attribute.String;
    media: Attribute.Media;
    paragraph: Attribute.Integer;
  };
}

export interface AQuestion extends Schema.Component {
  collectionName: 'components_a_questions';
  info: {
    displayName: 'question';
    icon: 'question';
  };
  attributes: {
    prompt: Attribute.String & Attribute.Required;
    expected_answer: Attribute.String;
  };
}

export interface AQuiz extends Schema.Component {
  collectionName: 'components_a_quizzes';
  info: {
    displayName: 'quiz';
    icon: 'bulletList';
  };
  attributes: {
    question: Attribute.String;
    options: Attribute.JSON;
    answer: Attribute.String;
    explanation: Attribute.String;
    audio: Attribute.Media;
  };
}

export interface AScenario extends Schema.Component {
  collectionName: 'components_a_scenarios';
  info: {
    displayName: 'scenario';
    description: '';
  };
  attributes: {
    title: Attribute.String & Attribute.Required;
    role: Attribute.String;
    role_context: Attribute.String;
  };
}

export interface ATaglist extends Schema.Component {
  collectionName: 'components_a_taglists';
  info: {
    displayName: 'taglist';
    icon: 'server';
  };
  attributes: {
    tag: Attribute.String;
  };
}

export interface AVerbMeta extends Schema.Component {
  collectionName: 'components_a_verb_metas';
  info: {
    displayName: 'verb_meta';
    icon: 'dashboard';
  };
  attributes: {
    simple_past: Attribute.String;
    past_participle: Attribute.String;
    present_participle: Attribute.String;
    thirdperson_singular: Attribute.String;
    auxiliary_verb: Attribute.String;
    conjugations: Attribute.JSON;
  };
}

declare module '@strapi/types' {
  export module Shared {
    export interface Components {
      'a.content-meta': AContentMeta;
      'a.exercise-meta': AExerciseMeta;
      'a.generation-prompts': AGenerationPrompts;
      'a.illustration-prompt': AIllustrationPrompt;
      'a.illustrations': AIllustrations;
      'a.question': AQuestion;
      'a.quiz': AQuiz;
      'a.scenario': AScenario;
      'a.taglist': ATaglist;
      'a.verb-meta': AVerbMeta;
    }
  }
}
