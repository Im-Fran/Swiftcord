//
//  Message.swift
//  Native Discord
//
//  Created by Vincent Kwok on 19/2/22.
//

import Foundation

enum MessageType: Int, Codable {
    case defaultMsg = 0
    case recipientAdd = 1
    case recipientRemove = 2
    case call = 3
    case chNameChange = 4
    case chIconChange = 5
    case chPinnedMsg = 6
    case guildMemberJoin = 7
    case userPremiumGuildSub = 8
    case userPremiumGuildSubTier1 = 9
    case userPremiumGuildSubTier2 = 10
    case userPremiumGuildSubTier3 = 11
    case chFollowAdd = 12
    case guildDiscoveryDisqualified = 14
    case guildDiscoveryRequalified = 15
    case guildDiscoveryGraceInitial = 16
    case guildDiscoveryGraceFinal = 17
    case threadCreated = 18
    case reply = 19
    case chatInputCmd = 20
    case threadStarterMsg = 21
    case guildInviteReminder = 22
    case contextMenuCmd = 23
}

struct Message: Codable, GatewayData {
    let id: Snowflake
    let channel_id: Snowflake
    let guild_id: Snowflake?
    let author: User
    let member: Member?
    let content: String // The message contents (up to 2000 characters)
    let timestamp: ISOTimestamp
    let edited_timestamp: ISOTimestamp?
    let tts: Bool
    let mention_everyone: Bool
    let mentions: [User]
    let mention_roles: [Snowflake] // Role IDs that were mentioned
    let mention_channels: [ChannelMention]?
    let attachments: [Attachment]
    let embeds: [Embed]
    let reactions: [Reaction]?
    // Nonce can either be string or int and isn't important so I'm not including it for now
    let pinned: Bool
    let webhook_id: Snowflake? // If the message is generated by a webhook, this is the webhook's id
    let type: MessageType
    let activity: MessageActivity?
    let application: Application?
    let application_id: Snowflake?
    let message_reference: MessageReference?
    let flags: Int?
    // Recursive properties don't work, so referenced_message can't be here for now
    let interaction: MessageInteraction?
    let thread: Channel?
    let components: [MessageComponent]?
    let sticker_items: [StickerItem]?
}

// A complete copy of Message but with most properties as Optional
// Swift doesn't have a Optional or Partial wrapper yet :(((
struct PartialMessage: Codable, GatewayData {
    let id: Snowflake
    let channel_id: Snowflake
    let guild_id: Snowflake?
    let author: User?
    let member: Member?
    let content: String? // The message contents (up to 2000 characters)
    let timestamp: ISOTimestamp?
    let edited_timestamp: ISOTimestamp?
    let tts: Bool?
    let mention_everyone: Bool?
    let mentions: [User]?
    let mention_roles: [Role]?
    let mention_channels: [ChannelMention]?
    let attachments: [Attachment]?
    let embeds: [Embed]?
    let reactions: [Reaction]?
    // Nonce can either be string or int and isn't important so I'm not including it for now
    let pinned: Bool?
    let webhook_id: Snowflake? // If the message is generated by a webhook, this is the webhook's id
    let type: MessageType?
    let activity: MessageActivity?
    let application: Application?
    let application_id: Snowflake?
    let message_reference: MessageReference?
    let flags: Int?
    // Recursive properties don't work, so referenced_message can't be here for now
    let interaction: MessageInteraction?
    let thread: Channel?
    let components: [MessageComponent]?
    let sticker_items: [StickerItem]?
}

// MARK: Mostly implemented message struct, missing file params
struct OutgoingMessage: Codable {
    let content: String // The message contents (up to 2000 characters)
    let tts: Bool?
    let embeds: [Embed]?
    let embed: Embed? // Embedded rich content, depreciated in favor of embeds
    let allowed_mentions: AllowedMentions?
    let message_reference: MessageReference?
    let components: [MessageComponent]?
    let sticker_ids: [Snowflake]?
    let flags: Int?
}

enum MessageActivityType: Int, Codable {
    case join = 1
    case spectate = 2
    case listen = 3
    case joinRequest = 5
}

struct MessageActivity: Codable {
    let type: MessageActivityType
    let party_id: String? // party_id from a Rich Presence event
}

// MARK: Reference an existing message as a reply
struct MessageReference: Codable {
    let message_id: Snowflake? // id of the originating message
    let channel_id: Snowflake? // id of the originating message's channel
    let guild_id: Snowflake? // id of the originating message's guild
    let fail_if_not_exists: Bool? // When sending, whether to error if the referenced message doesn't exist instead of sending as a normal (non-reply) message (default true)
}

enum MessageComponentTypes: Int, Codable {
    case actionRow = 1
    case button = 2
    case selectMenu = 3
    case textInput = 4
}

// MARK: New message component struct, incomplete
struct MessageComponent: Codable {
    let type: MessageComponentTypes
}
