'use strict';

const ExtensionSignatureVerificationCode = {
  Success: 'Success',
  RequiredArgumentMissing: 'RequiredArgumentMissing',
  InvalidArgument: 'InvalidArgument',
  PackageIsUnreadable: 'PackageIsUnreadable',
  UnhandledException: 'UnhandledException',
  SignatureManifestIsMissing: 'SignatureManifestIsMissing',
  SignatureManifestIsUnreadable: 'SignatureManifestIsUnreadable',
  SignatureIsMissing: 'SignatureIsMissing',
  SignatureIsUnreadable: 'SignatureIsUnreadable',
  CertificateIsUnreadable: 'CertificateIsUnreadable',
  SignatureArchiveIsUnreadable: 'SignatureArchiveIsUnreadable',
  FileAlreadyExists: 'FileAlreadyExists',
  SignatureArchiveIsInvalidZip: 'SignatureArchiveIsInvalidZip',
  SignatureArchiveHasSameSignatureFile: 'SignatureArchiveHasSameSignatureFile',
  PackageIntegrityCheckFailed: 'PackageIntegrityCheckFailed',
  SignatureIsInvalid: 'SignatureIsInvalid',
  SignatureManifestIsInvalid: 'SignatureManifestIsInvalid',
  SignatureIntegrityCheckFailed: 'SignatureIntegrityCheckFailed',
  EntryIsMissing: 'EntryIsMissing',
  EntryIsTampered: 'EntryIsTampered',
  Untrusted: 'Untrusted',
  CertificateRevoked: 'CertificateRevoked',
  SignatureIsNotValid: 'SignatureIsNotValid',
  UnknownError: 'UnknownError',
  PackageIsInvalidZip: 'PackageIsInvalidZip',
  SignatureArchiveHasTooManyEntries: 'SignatureArchiveHasTooManyEntries',
};

class ExtensionSignatureVerificationResult {
  constructor(code, didExecute, internalCode, output) {
    this.code = code;
    this.didExecute = didExecute;
    this.internalCode = internalCode;
    this.output = output;
  }
}

async function verify(vsixFilePath, signatureArchiveFilePath, verbose) {
  return new ExtensionSignatureVerificationResult(ExtensionSignatureVerificationCode.Success, false);
}

async function generateManifest(vsixFilePath, manifestFilePath, verbose) {
  return '';
}

async function zip(manifestFilePath, signatureFilePath, signatureArchiveFilePath, verbose) {
  return '';
}

module.exports = {
  verify,
  generateManifest,
  zip,
  ExtensionSignatureVerificationCode,
  ExtensionSignatureVerificationResult,
};
