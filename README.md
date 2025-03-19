# Blockchain-Enabled Historic Artifact Provenance

A decentralized solution for tracking, authenticating, and managing the lifecycle of historical artifacts with immutable record-keeping and enhanced transparency.

## Overview

The Blockchain-Enabled Historic Artifact Provenance system provides a secure, transparent, and tamper-proof framework for documenting the complete history of historical artifacts. By leveraging blockchain technology, this system creates an unbroken chain of custody records, authentication verifications, and exhibition histories that enhances trust in the provenance of valuable cultural and historical items.

## Core Components

### Artifact Registration Contract
Records comprehensive details and origin information of historical items upon first entry into the blockchain system.

- Captures detailed artifact metadata (dimensions, materials, date of creation, etc.)
- Documents origin information with supporting evidence
- Stores high-resolution imagery and 3D scans when available
- Creates a unique digital identifier linked to physical authentication markers
- Includes initial condition assessment and conservation needs

### Ownership Transfer Contract
Manages and tracks all transfers of possession throughout an artifact's history with cryptographic verification.

- Records complete chain of custody from origin to present
- Documents all sales, donations, inheritances, and institutional transfers
- Timestamps and cryptographically signs each ownership change
- Maintains privacy options for sensitive ownership information
- Links to supporting documentation (bills of sale, customs forms, etc.)
- Tracks geographical movement across borders

### Authentication Verification Contract
Validates and permanently records expert assessments and scientific testing of artifact authenticity.

- Stores credentials of authentication experts and institutions
- Records methodologies used in authentication processes
- Documents scientific testing results (carbon dating, spectroscopy, etc.)
- Implements multi-signature requirements for authentication consensus
- Maintains history of authentication disputes and resolutions
- Links physical authentication markers to blockchain records

### Exhibition History Contract
Creates a comprehensive record of public displays, museum loans, and exhibition appearances.

- Tracks exhibition dates, locations, and hosting institutions
- Records environmental conditions during display periods
- Documents conservation treatments before/after exhibitions
- Links to exhibition catalogs and scholarly publications
- Manages loan agreements and insurance records
- Monitors cumulative light exposure and other conservation metrics

## Technical Architecture

The system is built on a permissioned blockchain network that combines the benefits of decentralized record-keeping with controlled access for museums, auction houses, collectors, researchers, and regulatory bodies.

### Key Features

- **Immutable Records**: Once recorded, provenance information cannot be altered
- **Cryptographic Security**: Advanced encryption protects sensitive information
- **Selective Transparency**: Customizable privacy controls for different stakeholders
- **Interoperability**: Compatible with museum collection management systems
- **Digital-Physical Linking**: Integration with NFC/RFID tags and other physical markers
- **Time-Stamped Verification**: Cryptographically secure proof of when records were created

## Benefits

- **Fraud Prevention**: Drastically reduces the risk of forgeries entering the market
- **Dispute Resolution**: Clear provenance records help resolve ownership conflicts
- **Cultural Heritage Protection**: Helps identify and recover stolen or looted artifacts
- **Market Value Enhancement**: Well-documented provenance increases artifact value
- **Research Support**: Provides researchers with reliable artifact histories
- **Regulatory Compliance**: Simplifies compliance with cultural heritage laws
- **Insurance Efficiency**: Streamlines insurance processes with verified documentation

## Getting Started

### Prerequisites

- Hyperledger Fabric or Ethereum Enterprise network access
- Web3 or Hyperledger Fabric SDK
- NodeJS v14.0 or higher
- Hardware security modules for key management (recommended)

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/your-organization/artifact-provenance.git
   ```

2. Install dependencies:
   ```
   cd artifact-provenance
   npm install
   ```

3. Configure environment:
   ```
   cp .env.example .env
   # Edit .env with your blockchain network details
   ```

4. Deploy the smart contracts:
   ```
   # For Hyperledger Fabric
   ./deploy-chaincode.sh
   
   # For Ethereum
   truffle migrate --network mainnet
   ```

5. Initialize the admin account:
   ```
   node scripts/initialize-admin.js
   ```

### Configuration

The system requires configuration for various stakeholder access levels:

- **Museum Access**: Full read/write for owned artifacts, read-only for exhibited artifacts
- **Collector Access**: Read/write for owned artifacts, selective disclosure controls
- **Researcher Access**: Read-only with optional anonymized data export
- **Regulator Access**: Audit capabilities for compliance verification
- **Authentication Expert Access**: Limited write access for verification records

## Usage Examples

### Registering a New Artifact

```javascript
// Connect to the Artifact Registration contract
const registrationContract = await ArtifactRegistration.deployed();

// Register a new artifact
const artifactId = await registrationContract.registerArtifact(
  "Ancient Roman Coin - Denarius of Augustus",
  "27 BCE - 14 CE",
  "Silver",
  "Rome, Roman Empire",
  "19mm diameter, 3.9g weight",
  ipfsHashOfImages,
  initialOwner
);

// Add scientific analysis results
await registrationContract.addScientificAnalysis(
  artifactId,
  "X-ray fluorescence spectroscopy",
  "Silver content: 95.2%, Copper: 3.8%, Trace elements: 1%",
  labIdentifier,
  analysisDate
);
```

### Recording Ownership Transfer

```javascript
// Connect to the Ownership Transfer contract
const ownershipContract = await OwnershipTransfer.deployed();

// Record a sale transaction
await ownershipContract.transferOwnership(
  artifactId,
  currentOwner,
  newOwner,
  salePrice,
  currency,
  transactionDate,
  ipfsHashOfSaleDocuments
);
```

### Adding Authentication Verification

```javascript
// Connect to the Authentication contract
const authContract = await AuthenticationVerification.deployed();

// Record expert authentication
await authContract.addAuthentication(
  artifactId,
  expertId,
  "Visual inspection and stylistic analysis",
  "Authentic",
  "Consistent with known examples from the Augustan period",
  authenticationDate,
  ipfsHashOfReport
);

// Add scientific verification
await authContract.addScientificVerification(
  artifactId,
  labId,
  "Metallurgical analysis",
  "Composition consistent with Roman Imperial coinage",
  verificationDate,
  ipfsHashOfLabResults
);
```

### Recording Exhibition History

```javascript
// Connect to the Exhibition History contract
const exhibitionContract = await ExhibitionHistory.deployed();

// Record exhibition appearance
await exhibitionContract.recordExhibition(
  artifactId,
  "Imperial Rome: Power and People",
  "British Museum",
  "London, UK",
  startDate,
  endDate,
  "Climate-controlled display case, 50 lux illumination",
  ipfsHashOfExhibitionCatalog
);
```

## Security Considerations

- Cryptographic key management protocols for institutional users
- Multi-signature requirements for critical operations
- Access control layers with role-based permissions
- Regular security audits and penetration testing
- Cold storage options for private keys
- Physical-digital verification mechanisms to prevent system abuse

## Integration Options

- Museum Collection Management Systems (TMS, MuseumPlus, etc.)
- Auction House Platforms
- Academic Research Databases
- Customs and Border Protection Systems
- Insurance Provider Networks
- Mobile Applications for Authentication Verification

## Roadmap

- **Phase 1**: Core contract deployment and institutional onboarding
- **Phase 2**: Mobile application development for field authentication
- **Phase 3**: AI integration for forgery detection assistance
- **Phase 4**: Public API for research and market transparency
- **Phase 5**: International regulatory body integration

## Contributing

We welcome contributions from museums, collectors, technologists, and researchers:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the Apache 2.0 License - see the LICENSE file for details.

## Contact

Project Coordinator: provenance@example.org

## Acknowledgements

- The Getty Provenance Index
- International Council of Museums (ICOM)
- UNESCO Cultural Heritage Division
- Hyperledger Foundation
- International Foundation for Art Research (IFAR)
