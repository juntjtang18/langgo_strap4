import type { Schema, Attribute } from '@strapi/strapi';

export interface AExternalVideo extends Schema.Component {
  collectionName: 'components_a_external_videos';
  info: {
    displayName: 'external_video';
    icon: 'cast';
  };
  attributes: {
    url: Attribute.String;
    caption: Attribute.String;
  };
}

export interface APagebreaker extends Schema.Component {
  collectionName: 'components_a_pagebreakers';
  info: {
    displayName: 'pagebreaker';
    icon: 'expand';
  };
  attributes: {
    backbutton: Attribute.Boolean & Attribute.DefaultTo<true>;
    nextbutton: Attribute.Boolean & Attribute.DefaultTo<true>;
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

export interface ASentRef extends Schema.Component {
  collectionName: 'components_a_sent_refs';
  info: {
    displayName: 'sentRef';
    icon: 'discuss';
    description: '';
  };
  attributes: {
    sentence: Attribute.Relation<
      'a.sent-ref',
      'oneToOne',
      'api::sentence.sentence'
    >;
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

export interface AUserSentRef extends Schema.Component {
  collectionName: 'components_a_user_sent_refs';
  info: {
    displayName: 'UserSentRef';
    icon: 'command';
  };
  attributes: {
    user_sentence: Attribute.Relation<
      'a.user-sent-ref',
      'oneToOne',
      'api::user-sentence.user-sentence'
    >;
  };
}

export interface AUserWordRef extends Schema.Component {
  collectionName: 'components_a_user_word_refs';
  info: {
    displayName: 'UserWordRef';
    icon: 'dashboard';
  };
  attributes: {
    user_word: Attribute.Relation<
      'a.user-word-ref',
      'oneToOne',
      'api::user-word.user-word'
    >;
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

export interface AVideo extends Schema.Component {
  collectionName: 'components_a_videos';
  info: {
    displayName: 'video';
    icon: 'medium';
  };
  attributes: {
    media: Attribute.Media;
    thumbnail: Attribute.Media;
  };
}

export interface AWordRef extends Schema.Component {
  collectionName: 'components_a_word_refs';
  info: {
    displayName: 'wordRef';
    icon: 'dashboard';
  };
  attributes: {
    word: Attribute.Relation<'a.word-ref', 'oneToOne', 'api::word.word'>;
  };
}

declare module '@strapi/types' {
  export module Shared {
    export interface Components {
      'a.external-video': AExternalVideo;
      'a.pagebreaker': APagebreaker;
      'a.question': AQuestion;
      'a.quiz': AQuiz;
      'a.sent-ref': ASentRef;
      'a.taglist': ATaglist;
      'a.user-sent-ref': AUserSentRef;
      'a.user-word-ref': AUserWordRef;
      'a.verb-meta': AVerbMeta;
      'a.video': AVideo;
      'a.word-ref': AWordRef;
    }
  }
}
