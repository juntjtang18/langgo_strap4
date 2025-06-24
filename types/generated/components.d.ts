import type { Schema, Attribute } from '@strapi/strapi';

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
      'a.taglist': ATaglist;
      'a.verb-meta': AVerbMeta;
    }
  }
}
