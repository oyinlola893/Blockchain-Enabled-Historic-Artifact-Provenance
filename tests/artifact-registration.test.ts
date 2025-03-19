import { describe, it, expect, beforeEach } from "vitest"

// Mock the Clarity contract environment
const mockContractCaller = "ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM"
const mockBlockHeight = 100

// Mock contract state
let lastArtifactId = 0
const artifacts = new Map()

// Mock contract functions
const registerArtifact = (name, description, originLocation, originDate, creator, imageUri) => {
  const newId = lastArtifactId + 1
  
  artifacts.set(newId, {
    name,
    description,
    originLocation,
    originDate,
    creator,
    owner: mockContractCaller,
    registeredAt: mockBlockHeight,
    imageUri,
  })
  
  lastArtifactId = newId
  return { value: newId }
}

const getArtifact = (artifactId) => {
  return artifacts.get(artifactId) || null
}

const updateArtifactDetails = (artifactId, name, description, originLocation, originDate, creator, imageUri) => {
  const artifact = artifacts.get(artifactId)
  
  if (!artifact) {
    return { error: 404 }
  }
  
  if (artifact.owner !== mockContractCaller) {
    return { error: 403 }
  }
  
  artifacts.set(artifactId, {
    ...artifact,
    name,
    description,
    originLocation,
    originDate,
    creator,
    imageUri,
  })
  
  return { value: true }
}

describe("Artifact Registration Contract", () => {
  beforeEach(() => {
    // Reset state before each test
    lastArtifactId = 0
    artifacts.clear()
  })
  
  it("should register a new artifact", () => {
    const result = registerArtifact(
        "Ancient Vase",
        "A ceramic vase from the Ming Dynasty",
        "China",
        "1500 CE",
        "Unknown",
        "https://example.com/vase.jpg",
    )
    
    expect(result.value).toBe(1)
    expect(artifacts.size).toBe(1)
    
    const artifact = artifacts.get(1)
    expect(artifact).toBeDefined()
    expect(artifact.name).toBe("Ancient Vase")
    expect(artifact.description).toBe("A ceramic vase from the Ming Dynasty")
    expect(artifact.owner).toBe(mockContractCaller)
  })
  
  it("should retrieve an artifact by ID", () => {
    registerArtifact(
        "Ancient Vase",
        "A ceramic vase from the Ming Dynasty",
        "China",
        "1500 CE",
        "Unknown",
        "https://example.com/vase.jpg",
    )
    
    const artifact = getArtifact(1)
    
    expect(artifact).toBeDefined()
    expect(artifact.name).toBe("Ancient Vase")
    expect(artifact.originLocation).toBe("China")
  })
  
  it("should update artifact details", () => {
    registerArtifact(
        "Ancient Vase",
        "A ceramic vase from the Ming Dynasty",
        "China",
        "1500 CE",
        "Unknown",
        "https://example.com/vase.jpg",
    )
    
    const result = updateArtifactDetails(
        1,
        "Ming Dynasty Vase",
        "A rare ceramic vase from the Ming Dynasty",
        "China, Jingdezhen",
        "1505-1521 CE",
        "Imperial Workshop",
        "https://example.com/vase-updated.jpg",
    )
    
    expect(result.value).toBe(true)
    
    const updatedArtifact = getArtifact(1)
    expect(updatedArtifact.name).toBe("Ming Dynasty Vase")
    expect(updatedArtifact.description).toBe("A rare ceramic vase from the Ming Dynasty")
    expect(updatedArtifact.originLocation).toBe("China, Jingdezhen")
  })
  
  it("should not update artifact if not the owner", () => {
    registerArtifact(
        "Ancient Vase",
        "A ceramic vase from the Ming Dynasty",
        "China",
        "1500 CE",
        "Unknown",
        "https://example.com/vase.jpg",
    )
    
    // Change the mock contract caller
    const originalCaller = mockContractCaller
    Object.defineProperty(global, "mockContractCaller", {
      value: "ST2PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM",
    })
    
    const result = updateArtifactDetails(
        1,
        "Ming Dynasty Vase",
        "A rare ceramic vase from the Ming Dynasty",
        "China, Jingdezhen",
        "1505-1521 CE",
        "Imperial Workshop",
        "https://example.com/vase-updated.jpg",
    )
    
    expect(result.error).toBe(403)
    
    // Reset the mock contract caller
    Object.defineProperty(global, "mockContractCaller", {
      value: originalCaller,
    })
  })
})

