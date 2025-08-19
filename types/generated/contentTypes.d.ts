import type { Schema, Attribute } from '@strapi/strapi';

export interface AdminPermission extends Schema.CollectionType {
  collectionName: 'admin_permissions';
  info: {
    name: 'Permission';
    description: '';
    singularName: 'permission';
    pluralName: 'permissions';
    displayName: 'Permission';
  };
  pluginOptions: {
    'content-manager': {
      visible: false;
    };
    'content-type-builder': {
      visible: false;
    };
  };
  attributes: {
    action: Attribute.String &
      Attribute.Required &
      Attribute.SetMinMaxLength<{
        minLength: 1;
      }>;
    actionParameters: Attribute.JSON & Attribute.DefaultTo<{}>;
    subject: Attribute.String &
      Attribute.SetMinMaxLength<{
        minLength: 1;
      }>;
    properties: Attribute.JSON & Attribute.DefaultTo<{}>;
    conditions: Attribute.JSON & Attribute.DefaultTo<[]>;
    role: Attribute.Relation<'admin::permission', 'manyToOne', 'admin::role'>;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'admin::permission',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'admin::permission',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface AdminUser extends Schema.CollectionType {
  collectionName: 'admin_users';
  info: {
    name: 'User';
    description: '';
    singularName: 'user';
    pluralName: 'users';
    displayName: 'User';
  };
  pluginOptions: {
    'content-manager': {
      visible: false;
    };
    'content-type-builder': {
      visible: false;
    };
  };
  attributes: {
    firstname: Attribute.String &
      Attribute.SetMinMaxLength<{
        minLength: 1;
      }>;
    lastname: Attribute.String &
      Attribute.SetMinMaxLength<{
        minLength: 1;
      }>;
    username: Attribute.String;
    email: Attribute.Email &
      Attribute.Required &
      Attribute.Private &
      Attribute.Unique &
      Attribute.SetMinMaxLength<{
        minLength: 6;
      }>;
    password: Attribute.Password &
      Attribute.Private &
      Attribute.SetMinMaxLength<{
        minLength: 6;
      }>;
    resetPasswordToken: Attribute.String & Attribute.Private;
    registrationToken: Attribute.String & Attribute.Private;
    isActive: Attribute.Boolean &
      Attribute.Private &
      Attribute.DefaultTo<false>;
    roles: Attribute.Relation<'admin::user', 'manyToMany', 'admin::role'> &
      Attribute.Private;
    blocked: Attribute.Boolean & Attribute.Private & Attribute.DefaultTo<false>;
    preferedLanguage: Attribute.String;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<'admin::user', 'oneToOne', 'admin::user'> &
      Attribute.Private;
    updatedBy: Attribute.Relation<'admin::user', 'oneToOne', 'admin::user'> &
      Attribute.Private;
  };
}

export interface AdminRole extends Schema.CollectionType {
  collectionName: 'admin_roles';
  info: {
    name: 'Role';
    description: '';
    singularName: 'role';
    pluralName: 'roles';
    displayName: 'Role';
  };
  pluginOptions: {
    'content-manager': {
      visible: false;
    };
    'content-type-builder': {
      visible: false;
    };
  };
  attributes: {
    name: Attribute.String &
      Attribute.Required &
      Attribute.Unique &
      Attribute.SetMinMaxLength<{
        minLength: 1;
      }>;
    code: Attribute.String &
      Attribute.Required &
      Attribute.Unique &
      Attribute.SetMinMaxLength<{
        minLength: 1;
      }>;
    description: Attribute.String;
    users: Attribute.Relation<'admin::role', 'manyToMany', 'admin::user'>;
    permissions: Attribute.Relation<
      'admin::role',
      'oneToMany',
      'admin::permission'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<'admin::role', 'oneToOne', 'admin::user'> &
      Attribute.Private;
    updatedBy: Attribute.Relation<'admin::role', 'oneToOne', 'admin::user'> &
      Attribute.Private;
  };
}

export interface AdminApiToken extends Schema.CollectionType {
  collectionName: 'strapi_api_tokens';
  info: {
    name: 'Api Token';
    singularName: 'api-token';
    pluralName: 'api-tokens';
    displayName: 'Api Token';
    description: '';
  };
  pluginOptions: {
    'content-manager': {
      visible: false;
    };
    'content-type-builder': {
      visible: false;
    };
  };
  attributes: {
    name: Attribute.String &
      Attribute.Required &
      Attribute.Unique &
      Attribute.SetMinMaxLength<{
        minLength: 1;
      }>;
    description: Attribute.String &
      Attribute.SetMinMaxLength<{
        minLength: 1;
      }> &
      Attribute.DefaultTo<''>;
    type: Attribute.Enumeration<['read-only', 'full-access', 'custom']> &
      Attribute.Required &
      Attribute.DefaultTo<'read-only'>;
    accessKey: Attribute.String &
      Attribute.Required &
      Attribute.SetMinMaxLength<{
        minLength: 1;
      }>;
    lastUsedAt: Attribute.DateTime;
    permissions: Attribute.Relation<
      'admin::api-token',
      'oneToMany',
      'admin::api-token-permission'
    >;
    expiresAt: Attribute.DateTime;
    lifespan: Attribute.BigInteger;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'admin::api-token',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'admin::api-token',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface AdminApiTokenPermission extends Schema.CollectionType {
  collectionName: 'strapi_api_token_permissions';
  info: {
    name: 'API Token Permission';
    description: '';
    singularName: 'api-token-permission';
    pluralName: 'api-token-permissions';
    displayName: 'API Token Permission';
  };
  pluginOptions: {
    'content-manager': {
      visible: false;
    };
    'content-type-builder': {
      visible: false;
    };
  };
  attributes: {
    action: Attribute.String &
      Attribute.Required &
      Attribute.SetMinMaxLength<{
        minLength: 1;
      }>;
    token: Attribute.Relation<
      'admin::api-token-permission',
      'manyToOne',
      'admin::api-token'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'admin::api-token-permission',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'admin::api-token-permission',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface AdminTransferToken extends Schema.CollectionType {
  collectionName: 'strapi_transfer_tokens';
  info: {
    name: 'Transfer Token';
    singularName: 'transfer-token';
    pluralName: 'transfer-tokens';
    displayName: 'Transfer Token';
    description: '';
  };
  pluginOptions: {
    'content-manager': {
      visible: false;
    };
    'content-type-builder': {
      visible: false;
    };
  };
  attributes: {
    name: Attribute.String &
      Attribute.Required &
      Attribute.Unique &
      Attribute.SetMinMaxLength<{
        minLength: 1;
      }>;
    description: Attribute.String &
      Attribute.SetMinMaxLength<{
        minLength: 1;
      }> &
      Attribute.DefaultTo<''>;
    accessKey: Attribute.String &
      Attribute.Required &
      Attribute.SetMinMaxLength<{
        minLength: 1;
      }>;
    lastUsedAt: Attribute.DateTime;
    permissions: Attribute.Relation<
      'admin::transfer-token',
      'oneToMany',
      'admin::transfer-token-permission'
    >;
    expiresAt: Attribute.DateTime;
    lifespan: Attribute.BigInteger;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'admin::transfer-token',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'admin::transfer-token',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface AdminTransferTokenPermission extends Schema.CollectionType {
  collectionName: 'strapi_transfer_token_permissions';
  info: {
    name: 'Transfer Token Permission';
    description: '';
    singularName: 'transfer-token-permission';
    pluralName: 'transfer-token-permissions';
    displayName: 'Transfer Token Permission';
  };
  pluginOptions: {
    'content-manager': {
      visible: false;
    };
    'content-type-builder': {
      visible: false;
    };
  };
  attributes: {
    action: Attribute.String &
      Attribute.Required &
      Attribute.SetMinMaxLength<{
        minLength: 1;
      }>;
    token: Attribute.Relation<
      'admin::transfer-token-permission',
      'manyToOne',
      'admin::transfer-token'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'admin::transfer-token-permission',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'admin::transfer-token-permission',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface PluginUploadFile extends Schema.CollectionType {
  collectionName: 'files';
  info: {
    singularName: 'file';
    pluralName: 'files';
    displayName: 'File';
    description: '';
  };
  pluginOptions: {
    'content-manager': {
      visible: false;
    };
    'content-type-builder': {
      visible: false;
    };
  };
  attributes: {
    name: Attribute.String & Attribute.Required;
    alternativeText: Attribute.String;
    caption: Attribute.String;
    width: Attribute.Integer;
    height: Attribute.Integer;
    formats: Attribute.JSON;
    hash: Attribute.String & Attribute.Required;
    ext: Attribute.String;
    mime: Attribute.String & Attribute.Required;
    size: Attribute.Decimal & Attribute.Required;
    url: Attribute.String & Attribute.Required;
    previewUrl: Attribute.String;
    provider: Attribute.String & Attribute.Required;
    provider_metadata: Attribute.JSON;
    related: Attribute.Relation<'plugin::upload.file', 'morphToMany'>;
    folder: Attribute.Relation<
      'plugin::upload.file',
      'manyToOne',
      'plugin::upload.folder'
    > &
      Attribute.Private;
    folderPath: Attribute.String &
      Attribute.Required &
      Attribute.Private &
      Attribute.SetMinMax<{
        min: 1;
      }>;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'plugin::upload.file',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'plugin::upload.file',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface PluginUploadFolder extends Schema.CollectionType {
  collectionName: 'upload_folders';
  info: {
    singularName: 'folder';
    pluralName: 'folders';
    displayName: 'Folder';
  };
  pluginOptions: {
    'content-manager': {
      visible: false;
    };
    'content-type-builder': {
      visible: false;
    };
  };
  attributes: {
    name: Attribute.String &
      Attribute.Required &
      Attribute.SetMinMax<{
        min: 1;
      }>;
    pathId: Attribute.Integer & Attribute.Required & Attribute.Unique;
    parent: Attribute.Relation<
      'plugin::upload.folder',
      'manyToOne',
      'plugin::upload.folder'
    >;
    children: Attribute.Relation<
      'plugin::upload.folder',
      'oneToMany',
      'plugin::upload.folder'
    >;
    files: Attribute.Relation<
      'plugin::upload.folder',
      'oneToMany',
      'plugin::upload.file'
    >;
    path: Attribute.String &
      Attribute.Required &
      Attribute.SetMinMax<{
        min: 1;
      }>;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'plugin::upload.folder',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'plugin::upload.folder',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface PluginUsersPermissionsPermission
  extends Schema.CollectionType {
  collectionName: 'up_permissions';
  info: {
    name: 'permission';
    description: '';
    singularName: 'permission';
    pluralName: 'permissions';
    displayName: 'Permission';
  };
  pluginOptions: {
    'content-manager': {
      visible: false;
    };
    'content-type-builder': {
      visible: false;
    };
  };
  attributes: {
    action: Attribute.String & Attribute.Required;
    role: Attribute.Relation<
      'plugin::users-permissions.permission',
      'manyToOne',
      'plugin::users-permissions.role'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'plugin::users-permissions.permission',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'plugin::users-permissions.permission',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface PluginUsersPermissionsRole extends Schema.CollectionType {
  collectionName: 'up_roles';
  info: {
    name: 'role';
    description: '';
    singularName: 'role';
    pluralName: 'roles';
    displayName: 'Role';
  };
  pluginOptions: {
    'content-manager': {
      visible: false;
    };
    'content-type-builder': {
      visible: false;
    };
  };
  attributes: {
    name: Attribute.String &
      Attribute.Required &
      Attribute.SetMinMaxLength<{
        minLength: 3;
      }>;
    description: Attribute.String;
    type: Attribute.String & Attribute.Unique;
    permissions: Attribute.Relation<
      'plugin::users-permissions.role',
      'oneToMany',
      'plugin::users-permissions.permission'
    >;
    users: Attribute.Relation<
      'plugin::users-permissions.role',
      'oneToMany',
      'plugin::users-permissions.user'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'plugin::users-permissions.role',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'plugin::users-permissions.role',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface PluginUsersPermissionsUser extends Schema.CollectionType {
  collectionName: 'up_users';
  info: {
    name: 'user';
    description: '';
    singularName: 'user';
    pluralName: 'users';
    displayName: 'User';
  };
  options: {
    draftAndPublish: false;
    timestamps: true;
  };
  attributes: {
    username: Attribute.String &
      Attribute.Required &
      Attribute.Unique &
      Attribute.SetMinMaxLength<{
        minLength: 3;
      }>;
    email: Attribute.Email &
      Attribute.Required &
      Attribute.SetMinMaxLength<{
        minLength: 6;
      }>;
    provider: Attribute.String;
    password: Attribute.Password &
      Attribute.Private &
      Attribute.SetMinMaxLength<{
        minLength: 6;
      }>;
    resetPasswordToken: Attribute.String & Attribute.Private;
    confirmationToken: Attribute.String & Attribute.Private;
    confirmed: Attribute.Boolean & Attribute.DefaultTo<false>;
    blocked: Attribute.Boolean & Attribute.DefaultTo<false>;
    role: Attribute.Relation<
      'plugin::users-permissions.user',
      'manyToOne',
      'plugin::users-permissions.role'
    >;
    flashcards: Attribute.Relation<
      'plugin::users-permissions.user',
      'oneToMany',
      'api::flashcard.flashcard'
    >;
    reviewlogs: Attribute.Relation<
      'plugin::users-permissions.user',
      'oneToMany',
      'api::reviewlog.reviewlog'
    >;
    user_profile: Attribute.Relation<
      'plugin::users-permissions.user',
      'oneToOne',
      'api::user-profile.user-profile'
    >;
    user_words: Attribute.Relation<
      'plugin::users-permissions.user',
      'oneToMany',
      'api::user-word.user-word'
    >;
    user_sentences: Attribute.Relation<
      'plugin::users-permissions.user',
      'oneToMany',
      'api::user-sentence.user-sentence'
    >;
    vbsetting: Attribute.Relation<
      'plugin::users-permissions.user',
      'oneToOne',
      'api::vbsetting.vbsetting'
    >;
    story_likes: Attribute.Relation<
      'plugin::users-permissions.user',
      'oneToMany',
      'api::story-like.story-like'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'plugin::users-permissions.user',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'plugin::users-permissions.user',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface PluginI18NLocale extends Schema.CollectionType {
  collectionName: 'i18n_locale';
  info: {
    singularName: 'locale';
    pluralName: 'locales';
    collectionName: 'locales';
    displayName: 'Locale';
    description: '';
  };
  options: {
    draftAndPublish: false;
  };
  pluginOptions: {
    'content-manager': {
      visible: false;
    };
    'content-type-builder': {
      visible: false;
    };
  };
  attributes: {
    name: Attribute.String &
      Attribute.SetMinMax<{
        min: 1;
        max: 50;
      }>;
    code: Attribute.String & Attribute.Unique;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'plugin::i18n.locale',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'plugin::i18n.locale',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface ApiConversationConversation extends Schema.CollectionType {
  collectionName: 'conversations';
  info: {
    singularName: 'conversation';
    pluralName: 'conversations';
    displayName: 'Conversation';
    description: 'Custom API for conversation endpoints';
  };
  options: {
    draftAndPublish: false;
  };
  attributes: {
    sessionId: Attribute.String & Attribute.Required;
    history: Attribute.JSON;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::conversation.conversation',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::conversation.conversation',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface ApiDifficultyLevelDifficultyLevel
  extends Schema.CollectionType {
  collectionName: 'difficulty_levels';
  info: {
    singularName: 'difficulty-level';
    pluralName: 'difficulty-levels';
    displayName: 'difficulty_level';
    description: '';
  };
  options: {
    draftAndPublish: false;
  };
  pluginOptions: {
    i18n: {
      localized: true;
    };
  };
  attributes: {
    name: Attribute.String &
      Attribute.Required &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    level: Attribute.Integer &
      Attribute.Required &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }> &
      Attribute.DefaultTo<0>;
    topics: Attribute.Relation<
      'api::difficulty-level.difficulty-level',
      'oneToMany',
      'api::topic.topic'
    >;
    code: Attribute.Enumeration<['A1', 'A2', 'B1', 'B2', 'C1', 'C2']> &
      Attribute.Required &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: false;
        };
      }>;
    description: Attribute.String &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    stories: Attribute.Relation<
      'api::difficulty-level.difficulty-level',
      'oneToMany',
      'api::story.story'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::difficulty-level.difficulty-level',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::difficulty-level.difficulty-level',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    localizations: Attribute.Relation<
      'api::difficulty-level.difficulty-level',
      'oneToMany',
      'api::difficulty-level.difficulty-level'
    >;
    locale: Attribute.String;
  };
}

export interface ApiFlashcardFlashcard extends Schema.CollectionType {
  collectionName: 'flashcards';
  info: {
    singularName: 'flashcard';
    pluralName: 'flashcards';
    displayName: 'flashcard';
    description: '';
  };
  options: {
    draftAndPublish: false;
  };
  pluginOptions: {
    i18n: {
      localized: true;
    };
  };
  attributes: {
    user: Attribute.Relation<
      'api::flashcard.flashcard',
      'manyToOne',
      'plugin::users-permissions.user'
    >;
    last_reviewed_at: Attribute.DateTime &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: false;
        };
      }>;
    correct_streak: Attribute.Integer &
      Attribute.Required &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: false;
        };
      }> &
      Attribute.DefaultTo<0>;
    wrong_streak: Attribute.Integer &
      Attribute.Required &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: false;
        };
      }> &
      Attribute.DefaultTo<0>;
    is_remembered: Attribute.Boolean &
      Attribute.Required &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: false;
        };
      }> &
      Attribute.DefaultTo<false>;
    reviewlogs: Attribute.Relation<
      'api::flashcard.flashcard',
      'oneToMany',
      'api::reviewlog.reviewlog'
    >;
    review_tire: Attribute.Relation<
      'api::flashcard.flashcard',
      'manyToOne',
      'api::review-tire.review-tire'
    >;
    word_definition: Attribute.Relation<
      'api::flashcard.flashcard',
      'manyToOne',
      'api::word-definition.word-definition'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::flashcard.flashcard',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::flashcard.flashcard',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    localizations: Attribute.Relation<
      'api::flashcard.flashcard',
      'oneToMany',
      'api::flashcard.flashcard'
    >;
    locale: Attribute.String;
  };
}

export interface ApiLessonLesson extends Schema.CollectionType {
  collectionName: 'lessons';
  info: {
    singularName: 'lesson';
    pluralName: 'lessons';
    displayName: 'lesson';
    description: '';
  };
  options: {
    draftAndPublish: false;
  };
  pluginOptions: {
    i18n: {
      localized: true;
    };
  };
  attributes: {
    title: Attribute.String &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    slug: Attribute.UID<'api::lesson.lesson', 'title'> &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    description: Attribute.String &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    order: Attribute.Integer &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    tags: Attribute.Component<'a.taglist', true> &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    lessonlevel: Attribute.Relation<
      'api::lesson.lesson',
      'manyToOne',
      'api::lessonlevel.lessonlevel'
    >;
    sections: Attribute.Relation<
      'api::lesson.lesson',
      'oneToMany',
      'api::section.section'
    >;
    user_words: Attribute.Relation<
      'api::lesson.lesson',
      'oneToMany',
      'api::user-word.user-word'
    >;
    user_sentences: Attribute.Relation<
      'api::lesson.lesson',
      'oneToMany',
      'api::user-sentence.user-sentence'
    >;
    unit: Attribute.Relation<
      'api::lesson.lesson',
      'manyToOne',
      'api::unit.unit'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::lesson.lesson',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::lesson.lesson',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    localizations: Attribute.Relation<
      'api::lesson.lesson',
      'oneToMany',
      'api::lesson.lesson'
    >;
    locale: Attribute.String;
  };
}

export interface ApiLessonlevelLessonlevel extends Schema.CollectionType {
  collectionName: 'lessonlevels';
  info: {
    singularName: 'lessonlevel';
    pluralName: 'lessonlevels';
    displayName: 'lessonlevel';
    description: '';
  };
  options: {
    draftAndPublish: false;
  };
  attributes: {
    level: Attribute.String;
    description: Attribute.String;
    lessons: Attribute.Relation<
      'api::lessonlevel.lessonlevel',
      'oneToMany',
      'api::lesson.lesson'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::lessonlevel.lessonlevel',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::lessonlevel.lessonlevel',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface ApiModuleModule extends Schema.CollectionType {
  collectionName: 'modules';
  info: {
    singularName: 'module';
    pluralName: 'modules';
    displayName: 'module';
  };
  options: {
    draftAndPublish: false;
  };
  pluginOptions: {
    i18n: {
      localized: true;
    };
  };
  attributes: {
    name: Attribute.String &
      Attribute.Required &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    description: Attribute.String &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    goal: Attribute.String &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    icon_media: Attribute.Media &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: false;
        };
      }>;
    units: Attribute.Relation<
      'api::module.module',
      'oneToMany',
      'api::unit.unit'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::module.module',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::module.module',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    localizations: Attribute.Relation<
      'api::module.module',
      'oneToMany',
      'api::module.module'
    >;
    locale: Attribute.String;
  };
}

export interface ApiPartOfSpeechPartOfSpeech extends Schema.CollectionType {
  collectionName: 'part_of_speeches';
  info: {
    singularName: 'part-of-speech';
    pluralName: 'part-of-speeches';
    displayName: 'part of speech';
    description: '';
  };
  options: {
    draftAndPublish: false;
  };
  attributes: {
    name: Attribute.String;
    word_definitions: Attribute.Relation<
      'api::part-of-speech.part-of-speech',
      'oneToMany',
      'api::word-definition.word-definition'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::part-of-speech.part-of-speech',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::part-of-speech.part-of-speech',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface ApiPingPing extends Schema.CollectionType {
  collectionName: 'pings';
  info: {
    singularName: 'ping';
    pluralName: 'pings';
    displayName: 'ping';
  };
  options: {
    draftAndPublish: false;
  };
  attributes: {
    status: Attribute.String;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<'api::ping.ping', 'oneToOne', 'admin::user'> &
      Attribute.Private;
    updatedBy: Attribute.Relation<'api::ping.ping', 'oneToOne', 'admin::user'> &
      Attribute.Private;
  };
}

export interface ApiProficiencyLevelProficiencyLevel
  extends Schema.CollectionType {
  collectionName: 'proficiency_levels';
  info: {
    singularName: 'proficiency-level';
    pluralName: 'proficiency-levels';
    displayName: 'proficiency level';
  };
  options: {
    draftAndPublish: false;
  };
  pluginOptions: {
    i18n: {
      localized: true;
    };
  };
  attributes: {
    key: Attribute.String &
      Attribute.Required &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    displayName: Attribute.String &
      Attribute.Required &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    description: Attribute.String &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    level: Attribute.Integer &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: false;
        };
      }>;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::proficiency-level.proficiency-level',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::proficiency-level.proficiency-level',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    localizations: Attribute.Relation<
      'api::proficiency-level.proficiency-level',
      'oneToMany',
      'api::proficiency-level.proficiency-level'
    >;
    locale: Attribute.String;
  };
}

export interface ApiReviewTireReviewTire extends Schema.CollectionType {
  collectionName: 'review_tires';
  info: {
    singularName: 'review-tire';
    pluralName: 'review-tires';
    displayName: 'reviewTire';
    description: '';
  };
  options: {
    draftAndPublish: false;
  };
  pluginOptions: {
    i18n: {
      localized: true;
    };
  };
  attributes: {
    tier: Attribute.Enumeration<
      ['new', 'warmup', 'weekly', 'monthly', 'remembered']
    > &
      Attribute.Required &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    min_streak: Attribute.Integer &
      Attribute.Required &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: false;
        };
      }>;
    max_streak: Attribute.Integer &
      Attribute.Required &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: false;
        };
      }>;
    cooldown_hours: Attribute.Integer &
      Attribute.Required &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: false;
        };
      }>;
    demote_bar: Attribute.Integer &
      Attribute.Required &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: false;
        };
      }> &
      Attribute.DefaultTo<2>;
    flashcards: Attribute.Relation<
      'api::review-tire.review-tire',
      'oneToMany',
      'api::flashcard.flashcard'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::review-tire.review-tire',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::review-tire.review-tire',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    localizations: Attribute.Relation<
      'api::review-tire.review-tire',
      'oneToMany',
      'api::review-tire.review-tire'
    >;
    locale: Attribute.String;
  };
}

export interface ApiReviewlogReviewlog extends Schema.CollectionType {
  collectionName: 'reviewlogs';
  info: {
    singularName: 'reviewlog';
    pluralName: 'reviewlogs';
    displayName: 'reviewlog';
    description: '';
  };
  options: {
    draftAndPublish: false;
  };
  attributes: {
    user: Attribute.Relation<
      'api::reviewlog.reviewlog',
      'manyToOne',
      'plugin::users-permissions.user'
    >;
    reviewed_at: Attribute.DateTime;
    level: Attribute.Enumeration<
      ['new', 'warmup', 'daily', 'weekly', 'monthly', 'remembered']
    >;
    result: Attribute.Enumeration<['correct', 'wrong']> & Attribute.Required;
    flashcard: Attribute.Relation<
      'api::reviewlog.reviewlog',
      'manyToOne',
      'api::flashcard.flashcard'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::reviewlog.reviewlog',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::reviewlog.reviewlog',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface ApiSectionSection extends Schema.CollectionType {
  collectionName: 'sections';
  info: {
    singularName: 'section';
    pluralName: 'sections';
    displayName: 'section';
  };
  options: {
    draftAndPublish: false;
  };
  pluginOptions: {
    i18n: {
      localized: true;
    };
  };
  attributes: {
    title: Attribute.String &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    lesson: Attribute.Relation<
      'api::section.section',
      'manyToOne',
      'api::lesson.lesson'
    >;
    order: Attribute.Integer &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    components: Attribute.DynamicZone<
      [
        'a.word-ref',
        'a.video',
        'a.sent-ref',
        'a.quiz',
        'a.pagebreaker',
        'a.external-video'
      ]
    > &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    word_definitions: Attribute.Relation<
      'api::section.section',
      'oneToMany',
      'api::word-definition.word-definition'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::section.section',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::section.section',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    localizations: Attribute.Relation<
      'api::section.section',
      'oneToMany',
      'api::section.section'
    >;
    locale: Attribute.String;
  };
}

export interface ApiSentenceSentence extends Schema.CollectionType {
  collectionName: 'sentences';
  info: {
    singularName: 'sentence';
    pluralName: 'sentences';
    displayName: 'sentence';
    description: '';
  };
  options: {
    draftAndPublish: false;
  };
  pluginOptions: {
    i18n: {
      localized: true;
    };
  };
  attributes: {
    title: Attribute.String &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    instruction: Attribute.String &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    base_text: Attribute.String &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    target_text: Attribute.String &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: false;
        };
      }>;
    target_audio: Attribute.Media &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: false;
        };
      }>;
    tags: Attribute.Component<'a.taglist', true> &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    register: Attribute.Enumeration<['Formal', 'Informal', 'Neutral']> &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }> &
      Attribute.DefaultTo<'Neutral'>;
    exam_base: Attribute.JSON &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    exam_target: Attribute.JSON &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: false;
        };
      }>;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::sentence.sentence',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::sentence.sentence',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    localizations: Attribute.Relation<
      'api::sentence.sentence',
      'oneToMany',
      'api::sentence.sentence'
    >;
    locale: Attribute.String;
  };
}

export interface ApiStoryStory extends Schema.CollectionType {
  collectionName: 'stories';
  info: {
    singularName: 'story';
    pluralName: 'stories';
    displayName: 'story';
    description: '';
  };
  options: {
    draftAndPublish: false;
  };
  pluginOptions: {
    i18n: {
      localized: true;
    };
  };
  attributes: {
    title: Attribute.String &
      Attribute.Required &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    author: Attribute.String &
      Attribute.Required &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    brief: Attribute.Text &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    text: Attribute.Text &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    slug: Attribute.UID<'api::story.story', 'title'> &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    order: Attribute.Integer &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    word_count: Attribute.Integer &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    difficulty_level: Attribute.Relation<
      'api::story.story',
      'manyToOne',
      'api::difficulty-level.difficulty-level'
    >;
    illustrations: Attribute.Component<'a.illustrations', true> &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: false;
        };
      }>;
    generation_prompts: Attribute.Component<'a.generation-prompts'> &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    like_count: Attribute.Integer &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: false;
        };
      }> &
      Attribute.DefaultTo<0>;
    story_likes: Attribute.Relation<
      'api::story.story',
      'oneToMany',
      'api::story-like.story-like'
    >;
    story_audios: Attribute.Relation<
      'api::story.story',
      'oneToMany',
      'api::story-audio.story-audio'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::story.story',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::story.story',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    localizations: Attribute.Relation<
      'api::story.story',
      'oneToMany',
      'api::story.story'
    >;
    locale: Attribute.String;
  };
}

export interface ApiStoryAudioStoryAudio extends Schema.CollectionType {
  collectionName: 'story_audios';
  info: {
    singularName: 'story-audio';
    pluralName: 'story-audios';
    displayName: 'story audio';
    description: '';
  };
  options: {
    draftAndPublish: false;
  };
  attributes: {
    key_hash: Attribute.UID & Attribute.Required;
    source_text: Attribute.String;
    provider: Attribute.Enumeration<['azure', 'google', 'polly', 'openapi']>;
    engine_ver: Attribute.String;
    voice_id: Attribute.String;
    format: Attribute.Enumeration<['mp3', 'm4a', 'wav', 'opus']>;
    rate: Attribute.Decimal;
    duration_s: Attribute.Decimal;
    audio: Attribute.Media & Attribute.Required;
    expires_at: Attribute.DateTime;
    story: Attribute.Relation<
      'api::story-audio.story-audio',
      'manyToOne',
      'api::story.story'
    >;
    paragraph_index: Attribute.Integer;
    sentence_index: Attribute.Integer;
    pitch: Attribute.Decimal;
    volume: Attribute.Decimal;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::story-audio.story-audio',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::story-audio.story-audio',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface ApiStoryLikeStoryLike extends Schema.CollectionType {
  collectionName: 'story_likes';
  info: {
    singularName: 'story-like';
    pluralName: 'story-likes';
    displayName: 'story like';
  };
  options: {
    draftAndPublish: false;
  };
  attributes: {
    user: Attribute.Relation<
      'api::story-like.story-like',
      'manyToOne',
      'plugin::users-permissions.user'
    >;
    story: Attribute.Relation<
      'api::story-like.story-like',
      'manyToOne',
      'api::story.story'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::story-like.story-like',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::story-like.story-like',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface ApiTopicTopic extends Schema.CollectionType {
  collectionName: 'topics';
  info: {
    singularName: 'topic';
    pluralName: 'topics';
    displayName: 'topic';
  };
  options: {
    draftAndPublish: false;
  };
  attributes: {
    title: Attribute.String & Attribute.Required;
    difficulty_level: Attribute.Relation<
      'api::topic.topic',
      'manyToOne',
      'api::difficulty-level.difficulty-level'
    >;
    description: Attribute.String;
    questions: Attribute.Component<'a.question', true>;
    tags: Attribute.String;
    is_active: Attribute.Boolean & Attribute.DefaultTo<true>;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::topic.topic',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::topic.topic',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface ApiUnitUnit extends Schema.CollectionType {
  collectionName: 'units';
  info: {
    singularName: 'unit';
    pluralName: 'units';
    displayName: 'unit';
    description: '';
  };
  options: {
    draftAndPublish: false;
  };
  pluginOptions: {
    i18n: {
      localized: true;
    };
  };
  attributes: {
    title: Attribute.String &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    slug: Attribute.UID<'api::unit.unit', 'title'> &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    description: Attribute.String &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    order: Attribute.Integer &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: false;
        };
      }>;
    lessons: Attribute.Relation<
      'api::unit.unit',
      'oneToMany',
      'api::lesson.lesson'
    >;
    precondition: Attribute.Relation<
      'api::unit.unit',
      'oneToOne',
      'api::unit.unit'
    >;
    unlocks: Attribute.Relation<'api::unit.unit', 'oneToOne', 'api::unit.unit'>;
    module: Attribute.Relation<
      'api::unit.unit',
      'manyToOne',
      'api::module.module'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<'api::unit.unit', 'oneToOne', 'admin::user'> &
      Attribute.Private;
    updatedBy: Attribute.Relation<'api::unit.unit', 'oneToOne', 'admin::user'> &
      Attribute.Private;
    localizations: Attribute.Relation<
      'api::unit.unit',
      'oneToMany',
      'api::unit.unit'
    >;
    locale: Attribute.String;
  };
}

export interface ApiUserProfileUserProfile extends Schema.CollectionType {
  collectionName: 'user_profiles';
  info: {
    singularName: 'user-profile';
    pluralName: 'user-profiles';
    displayName: 'userProfile';
    description: '';
  };
  options: {
    draftAndPublish: false;
  };
  attributes: {
    user: Attribute.Relation<
      'api::user-profile.user-profile',
      'oneToOne',
      'plugin::users-permissions.user'
    >;
    telephone: Attribute.String;
    baseLanguage: Attribute.String & Attribute.Required;
    proficiency: Attribute.String;
    reminder_enabled: Attribute.Boolean;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::user-profile.user-profile',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::user-profile.user-profile',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface ApiUserSentenceUserSentence extends Schema.CollectionType {
  collectionName: 'user_sentences';
  info: {
    singularName: 'user-sentence';
    pluralName: 'user-sentences';
    displayName: 'user_sentence';
    description: '';
  };
  options: {
    draftAndPublish: false;
  };
  pluginOptions: {
    i18n: {
      localized: true;
    };
  };
  attributes: {
    user: Attribute.Relation<
      'api::user-sentence.user-sentence',
      'manyToOne',
      'plugin::users-permissions.user'
    >;
    target_text: Attribute.String &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: false;
        };
      }>;
    base_text: Attribute.String &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    lesson: Attribute.Relation<
      'api::user-sentence.user-sentence',
      'manyToOne',
      'api::lesson.lesson'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::user-sentence.user-sentence',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::user-sentence.user-sentence',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    localizations: Attribute.Relation<
      'api::user-sentence.user-sentence',
      'oneToMany',
      'api::user-sentence.user-sentence'
    >;
    locale: Attribute.String;
  };
}

export interface ApiUserWordUserWord extends Schema.CollectionType {
  collectionName: 'user_words';
  info: {
    singularName: 'user-word';
    pluralName: 'user-words';
    displayName: 'user_word';
    description: '';
  };
  options: {
    draftAndPublish: false;
  };
  pluginOptions: {
    i18n: {
      localized: true;
    };
  };
  attributes: {
    user: Attribute.Relation<
      'api::user-word.user-word',
      'manyToOne',
      'plugin::users-permissions.user'
    >;
    target_text: Attribute.String &
      Attribute.Required &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: false;
        };
      }>;
    base_text: Attribute.String &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    part_of_speech: Attribute.Enumeration<
      [
        'noun',
        'verb',
        'adjective',
        'adverb',
        'conjunction',
        'preposition',
        'interjection',
        'determiner',
        'pronoun'
      ]
    > &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    lesson: Attribute.Relation<
      'api::user-word.user-word',
      'manyToOne',
      'api::lesson.lesson'
    >;
    exam_base: Attribute.JSON &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: false;
        };
      }>;
    exam_target: Attribute.JSON &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: false;
        };
      }>;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::user-word.user-word',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::user-word.user-word',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    localizations: Attribute.Relation<
      'api::user-word.user-word',
      'oneToMany',
      'api::user-word.user-word'
    >;
    locale: Attribute.String;
  };
}

export interface ApiVbsettingVbsetting extends Schema.CollectionType {
  collectionName: 'vbsettings';
  info: {
    singularName: 'vbsetting';
    pluralName: 'vbsettings';
    displayName: 'vbsetting';
  };
  options: {
    draftAndPublish: false;
  };
  attributes: {
    user: Attribute.Relation<
      'api::vbsetting.vbsetting',
      'oneToOne',
      'plugin::users-permissions.user'
    >;
    wordsPerPage: Attribute.Integer &
      Attribute.Required &
      Attribute.DefaultTo<12>;
    interval1: Attribute.Decimal & Attribute.DefaultTo<1.5>;
    interval2: Attribute.Decimal & Attribute.DefaultTo<2>;
    interval3: Attribute.Decimal & Attribute.DefaultTo<2>;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::vbsetting.vbsetting',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::vbsetting.vbsetting',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface ApiWordWord extends Schema.CollectionType {
  collectionName: 'words';
  info: {
    singularName: 'word';
    pluralName: 'words';
    displayName: 'word';
  };
  options: {
    draftAndPublish: false;
  };
  attributes: {
    target_text: Attribute.String & Attribute.Required & Attribute.Unique;
    word_definitions: Attribute.Relation<
      'api::word.word',
      'oneToMany',
      'api::word-definition.word-definition'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<'api::word.word', 'oneToOne', 'admin::user'> &
      Attribute.Private;
    updatedBy: Attribute.Relation<'api::word.word', 'oneToOne', 'admin::user'> &
      Attribute.Private;
  };
}

export interface ApiWordDefAudioWordDefAudio extends Schema.CollectionType {
  collectionName: 'word_def_audios';
  info: {
    singularName: 'word-def-audio';
    pluralName: 'word-def-audios';
    displayName: 'word def audio';
  };
  options: {
    draftAndPublish: false;
  };
  attributes: {
    key_hash: Attribute.UID & Attribute.Required;
    provider: Attribute.Enumeration<['azure', 'google', 'polly', 'openai']>;
    engine_ver: Attribute.String;
    voice_id: Attribute.String;
    format: Attribute.Enumeration<['mp3', 'm4a', 'wav', 'opus']>;
    rate: Attribute.Decimal;
    duration_s: Attribute.Decimal;
    pitch: Attribute.Decimal;
    volume: Attribute.Decimal;
    audio: Attribute.Media;
    expires_at: Attribute.DateTime;
    word_definition: Attribute.Relation<
      'api::word-def-audio.word-def-audio',
      'manyToOne',
      'api::word-definition.word-definition'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::word-def-audio.word-def-audio',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::word-def-audio.word-def-audio',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
  };
}

export interface ApiWordDefinitionWordDefinition extends Schema.CollectionType {
  collectionName: 'word_definitions';
  info: {
    singularName: 'word-definition';
    pluralName: 'word-definitions';
    displayName: 'word definition';
    description: '';
  };
  options: {
    draftAndPublish: false;
  };
  pluginOptions: {
    i18n: {
      localized: true;
    };
  };
  attributes: {
    word: Attribute.Relation<
      'api::word-definition.word-definition',
      'manyToOne',
      'api::word.word'
    >;
    section: Attribute.Relation<
      'api::word-definition.word-definition',
      'manyToOne',
      'api::section.section'
    >;
    base_text: Attribute.String &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    instruction: Attribute.String &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    part_of_speech: Attribute.Relation<
      'api::word-definition.word-definition',
      'manyToOne',
      'api::part-of-speech.part-of-speech'
    >;
    gender: Attribute.Enumeration<['masculine', 'feminine', 'neuter']> &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: false;
        };
      }>;
    article: Attribute.String &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: false;
        };
      }>;
    tags: Attribute.Component<'a.taglist'> &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    example_sentence: Attribute.String &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    verb_meta: Attribute.Component<'a.verb-meta'> &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    exam_base: Attribute.JSON &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    exam_target: Attribute.JSON &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    register: Attribute.Enumeration<['Formal', 'Informal', 'Neutral']> &
      Attribute.SetPluginOptions<{
        i18n: {
          localized: true;
        };
      }>;
    flashcards: Attribute.Relation<
      'api::word-definition.word-definition',
      'oneToMany',
      'api::flashcard.flashcard'
    >;
    word_def_audios: Attribute.Relation<
      'api::word-definition.word-definition',
      'oneToMany',
      'api::word-def-audio.word-def-audio'
    >;
    createdAt: Attribute.DateTime;
    updatedAt: Attribute.DateTime;
    createdBy: Attribute.Relation<
      'api::word-definition.word-definition',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    updatedBy: Attribute.Relation<
      'api::word-definition.word-definition',
      'oneToOne',
      'admin::user'
    > &
      Attribute.Private;
    localizations: Attribute.Relation<
      'api::word-definition.word-definition',
      'oneToMany',
      'api::word-definition.word-definition'
    >;
    locale: Attribute.String;
  };
}

declare module '@strapi/types' {
  export module Shared {
    export interface ContentTypes {
      'admin::permission': AdminPermission;
      'admin::user': AdminUser;
      'admin::role': AdminRole;
      'admin::api-token': AdminApiToken;
      'admin::api-token-permission': AdminApiTokenPermission;
      'admin::transfer-token': AdminTransferToken;
      'admin::transfer-token-permission': AdminTransferTokenPermission;
      'plugin::upload.file': PluginUploadFile;
      'plugin::upload.folder': PluginUploadFolder;
      'plugin::users-permissions.permission': PluginUsersPermissionsPermission;
      'plugin::users-permissions.role': PluginUsersPermissionsRole;
      'plugin::users-permissions.user': PluginUsersPermissionsUser;
      'plugin::i18n.locale': PluginI18NLocale;
      'api::conversation.conversation': ApiConversationConversation;
      'api::difficulty-level.difficulty-level': ApiDifficultyLevelDifficultyLevel;
      'api::flashcard.flashcard': ApiFlashcardFlashcard;
      'api::lesson.lesson': ApiLessonLesson;
      'api::lessonlevel.lessonlevel': ApiLessonlevelLessonlevel;
      'api::module.module': ApiModuleModule;
      'api::part-of-speech.part-of-speech': ApiPartOfSpeechPartOfSpeech;
      'api::ping.ping': ApiPingPing;
      'api::proficiency-level.proficiency-level': ApiProficiencyLevelProficiencyLevel;
      'api::review-tire.review-tire': ApiReviewTireReviewTire;
      'api::reviewlog.reviewlog': ApiReviewlogReviewlog;
      'api::section.section': ApiSectionSection;
      'api::sentence.sentence': ApiSentenceSentence;
      'api::story.story': ApiStoryStory;
      'api::story-audio.story-audio': ApiStoryAudioStoryAudio;
      'api::story-like.story-like': ApiStoryLikeStoryLike;
      'api::topic.topic': ApiTopicTopic;
      'api::unit.unit': ApiUnitUnit;
      'api::user-profile.user-profile': ApiUserProfileUserProfile;
      'api::user-sentence.user-sentence': ApiUserSentenceUserSentence;
      'api::user-word.user-word': ApiUserWordUserWord;
      'api::vbsetting.vbsetting': ApiVbsettingVbsetting;
      'api::word.word': ApiWordWord;
      'api::word-def-audio.word-def-audio': ApiWordDefAudioWordDefAudio;
      'api::word-definition.word-definition': ApiWordDefinitionWordDefinition;
    }
  }
}
