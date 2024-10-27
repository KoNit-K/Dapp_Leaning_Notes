# 🔐 MPC 钱包概述
---

**语言**：[English](./README.md) | [中文](./README_zh.md)  

---

在传统的公钥加密体系中，签名通过私钥生成，但单一私钥的存在增加了安全风险。**MPC 签名**通过**安全多方计算（Secure Multi-Party Computation, MPC）**来实现分布式签名，确保完整私钥从未出现在单一位置。每个参与者持有私钥的“分片”，只需达到特定数量的分片组合，就可以生成有效签名。

---

### 🌟 MPC (门限签名方案, TSS) vs. 多重签名

MPC 签名，即**门限签名方案（Threshold Signature Scheme, TSS）**，与传统多重签名有所不同，优势如下：

1. **去中心化生成（Dealerless）** - 无需私钥分发者，**完整私钥不会在生成过程中出现**。
2. **门限签名** - 每次签名需要 M 个参与者（M ≤ N）成功参与。
3. **聚合签名** - 生成单一、完整的签名，**减少链上交易成本**。
4. **私钥恢复** - M 个参与者（M ≤ N）可共同恢复私钥分片。

---

## 📐 Shamir 秘密共享（SSS）算法

多种 TSS 协议使用 **Shamir 的秘密共享（Shamir's Secret Sharing, SSS）**算法。SSS 旨在安全地分配私密信息（“秘密”），使得单个持有者无法单独重建秘密，只有足够数量的持有者才能合作重建。

### 🔑 SSS 工作原理
SSS 基于**拉格朗日插值定理（Lagrange Interpolation Theorem）**，允许使用 *K* 个点构造唯一的多项式 **P(x)**。若满足足够数量的份额，便能重建秘密；否则即便攻击者拥有无限时间与计算能力，也无法破解。

### 📊 示例

给定数据点 (1, 2), (2, 3) 和 (3, 5)，可以构造一个二次多项式 **P(x)**，使得：
- P(1) = 2，P(2) = 3，P(3) = 5  
- 多项式的常数项（a0）即为秘密。

示例如图：

![SSS_example](./SSS_example.jpg)

例如构造一个二次多项式，将私钥分配给六个管理者，最少只需三份分片即可完成签名。

---

## ⚠️ 问题与解决方案

### 问题：
1. 若某分片作恶，则难以识别出提供错误签名的分片。

### 解决方案 - **Feldman 可验证秘密共享（VSS）**
**Feldman VSS** 通过以下方式来识别恶意方：
1. **可验证秘密共享（VSS）** - 可以识别并追踪恶意行为。
2. 在 SSS 的基础上，添加了模运算：**P(x) = a0 + a1x + a2x^2 + ... + anx^n mod q**。

---

## 🔄 MPC / 门限签名流程

### 私钥/地址生成流程
1. 发送地址创建请求（用户 → Services 服务）
2. 发送 Keygen 请求（Services 服务 → MPC 网络）
3. 节点生成密钥片段（MPC 网络）
4. 生成聚合公钥（MPC 网络 → Services 服务）
5. 生成地址（Services 服务）
6. 返回地址（Services 服务 → 用户）

### 签名过程
1. 用户发起提现请求（用户 → services 服务）
2. 构建交易（services 服务）
3. 签名指令带携交易 msg（services 服务 → MPC 网络）
4. MPC 网络中各个节点的签名操作（MPC 网络）
5. 返回签名后的 signature（MPC 网络 → services 服务）
6. 使用聚合公钥验证签名（services 服务）
7. 获得 RSV
8. 构建完整的交易（services 服务）
9. 发送到区块链网络上（services 服务 → 区块链网络）
10. 交易构建完成

---

## 🧩 TSS 变种

1. **GG18** (2018) - 由 Rosario Gennaro 和 Steven Goldfeder 提出  
   - 有中心化协调者负责。
   - 无法识别恶意参与者。
   - [币安的 GG18 实现](https://github.com/bnb-chain/tss-lib)

2. **GG20** (2020) - 由 Rosario Gennaro 和 Steven Goldfeder 提出  
   - 无中心化协调者，参与者互相作为协调者。
   - 减少了交互轮次。
   - 可识别恶意参与者。
   - [ZenGo 的 GG20 实现（Rust）](https://github.com/ZenGo-X/multi-party-ecdsa)

3. **DMZ21**  
   - 减少了交互轮次。
   - 提高了效率。

---

## 📚 引用

### 开源代码
- **ZenGo** - [Rust 实现 GG20](https://github.com/ZenGo-X/multi-party-ecdsa)
- **QuquZone** - [基于 ZenGo 的 TSS 库 (Rust)](https://github.com/ququzone/tss-lib)
- **LatticeX** - [DMZ 实现 (Rust)](https://github.com/LatticeX-Foundation/opentss)
- **BNB Chain** - [Go 实现 GG18](https://github.com/bnb-chain/tss-lib)
- **Thorchain** - [Go 实现 GG20](https://gitlab.com/thorchain/thornode/-/tree/develop/bifrost/tss/go-tss)

### 相关资料
1. [Dapp Learning 开放大学](https://www.youtube.com/watch?v=Da9dhEK3vg0)
2. [0xweb3 - MPC 钱包原理](https://github.com/0xweb-3/web3_share/tree/main/wallet-doc/04.MPC%E6%89%98%E7%AE%A1%E9%92%B1%E5%8C%85%E5%8E%9F%E7%90%86)
3. [GG20 文章](https://eprint.iacr.org/2020/540.pdf)
