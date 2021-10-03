import 'package:flutter_stickers_internet/app/model/sticker.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stickerPack.g.dart';

@JsonSerializable()
class StickerPack {

  String identifier;
  String name;
  String publisher;
  @JsonKey(name: 'tray_image_file')
  String trayimagefile;
  @JsonKey(name: 'publisher_email')
  String publisheremail;
  @JsonKey(name: 'publisher_website')
  String publisherwebsite;
  @JsonKey(name: 'privacy_policy_website')
  String privacypolicywebsite;
  @JsonKey(name: 'license_agreement_website')
  String licenseagreementwebsite;
  @JsonKey(name: 'color')
  String color;
  @JsonKey(name: 'stickers')
  List<Sticker> stickers;

  StickerPack({
      this.identifier = '',
      this.name = '',
      this.publisher = '',
      this.trayimagefile ='',
      this.publisheremail = '',
      this.publisherwebsite = '',
      this.privacypolicywebsite = '',
      this.licenseagreementwebsite= '',
      this.color = '',
      required this.stickers});

  factory StickerPack.fromJson(Map<String, dynamic> json) =>
      _$StickerPackFromJson(json);

  Map<String, dynamic> toJson() => _$StickerPackToJson(this);

  String get identiFier => identifier;
  String get names => name;
  String get publishers => publisher;
  String get trayimageFile => trayimagefile;
  String get publisherEmail => publisheremail;
  String get publisherWebsite => publisherwebsite;
  String get privacyPolicyWebsite => privacypolicywebsite;
  String get licenseAgreementWebsite => licenseagreementwebsite;
  String get coloR => color;
  List<Sticker> get sticker => stickers;

  set identiFier(String identifier){
    this.identifier = identifier;
  }

  set names(String name){
    this.name = name;
  }

  set publishers(String publisher){
    this.publisher = publisher;
  }

  set trayimageFile(String trayimagefile){
    this.trayimagefile = trayimagefile;
  }

  set publisherEmail(String publisheremail){
    this.publisheremail = publisheremail;
  }

  set publisherWebsite(String publisherwebsite){
    this.publisherwebsite = publisherwebsite;
  }

  set privacyPolicyWebsite(String privacypolicywebsite){
    this.privacypolicywebsite = privacypolicywebsite;
  }

  set licenseAgreementWebsite(String licenseagreementwebsite){
    this.licenseagreementwebsite = licenseagreementwebsite;
  }

  set coloR(String coloR){
    this.color = coloR;
  }

  set sticker(List<Sticker> stickers){
    this.stickers = stickers;
  }
}