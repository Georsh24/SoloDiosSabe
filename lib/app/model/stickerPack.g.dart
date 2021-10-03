// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stickerPack.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StickerPack _$StickerPackFromJson(Map<String, dynamic> json) => StickerPack(
      identifier: json['identifier'] as String? ?? '',
      name: json['name'] as String? ?? '',
      publisher: json['publisher'] as String? ?? '',
      trayimagefile: json['tray_image_file'] as String? ?? '',
      publisheremail: json['publisher_email'] as String? ?? '',
      publisherwebsite: json['publisher_website'] as String? ?? '',
      privacypolicywebsite: json['privacy_policy_website'] as String? ?? '',
      licenseagreementwebsite:
          json['license_agreement_website'] as String? ?? '',
      color: json['color'] as String? ?? '',
      stickers: (json['stickers'] as List<dynamic>)
          .map((e) => Sticker.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..identiFier = json['identiFier'] as String
      ..names = json['names'] as String
      ..publishers = json['publishers'] as String
      ..trayimageFile = json['trayimageFile'] as String
      ..publisherEmail = json['publisherEmail'] as String
      ..publisherWebsite = json['publisherWebsite'] as String
      ..privacyPolicyWebsite = json['privacyPolicyWebsite'] as String
      ..licenseAgreementWebsite = json['licenseAgreementWebsite'] as String
      ..coloR = json['coloR'] as String
      ..sticker = (json['sticker'] as List<dynamic>)
          .map((e) => Sticker.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$StickerPackToJson(StickerPack instance) =>
    <String, dynamic>{
      'identifier': instance.identifier,
      'name': instance.name,
      'publisher': instance.publisher,
      'tray_image_file': instance.trayimagefile,
      'publisher_email': instance.publisheremail,
      'publisher_website': instance.publisherwebsite,
      'privacy_policy_website': instance.privacypolicywebsite,
      'license_agreement_website': instance.licenseagreementwebsite,
      'color': instance.color,
      'stickers': instance.stickers,
      'identiFier': instance.identiFier,
      'names': instance.names,
      'publishers': instance.publishers,
      'trayimageFile': instance.trayimageFile,
      'publisherEmail': instance.publisherEmail,
      'publisherWebsite': instance.publisherWebsite,
      'privacyPolicyWebsite': instance.privacyPolicyWebsite,
      'licenseAgreementWebsite': instance.licenseAgreementWebsite,
      'coloR': instance.coloR,
      'sticker': instance.sticker,
    };
