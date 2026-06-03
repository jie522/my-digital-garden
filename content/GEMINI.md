g# Gemini CLI 知識庫管理指令 (Karpathy Style LLM Wiki)

此文件結合了 Karpathy 的 LLM Wiki 框架與系統部署規範，定義了 Gemini CLI 協助維護個人知識庫的最高運作準則。

## 1. 系統目標與結構
模仿 Andrej Karpathy 的個人 Wiki 系統，建立一個 AI 與人類協作的知識網絡。

### 核心三層結構 (The Three Layers)
- **📁 Raw Source (原始資料層)**: 存放於 `/Raw/`。收集原始素材（Markdown, PDF, 網頁剪取）。
- **📝 The Wiki (精華知識層)**: 存放於 `/Wiki/`。AI 提煉後的結構化知識，透過雙向連結 (`[[連結]]`) 互聯。
- **⚙️ The Schema (協作規範層)**: 即本 `GEMINI.md` 文件。定義 AI 與人類的協作規則。

## 2. 目錄與檔案結構規範
- `/Raw/`: 存放原始素材。
- `/Wiki/Concepts/`: 核心概念、理論、技術定義。
- `/Wiki/Entities/`: 實體頁面（人物、組織、軟體、工具）。**採扁平化管理，禁止使用子資料夾。**
- `/Wiki/Sources/`: 原始文章的摘要與其貢獻的知識點對照。
- `/Index.md`: 全域索引，列出所有頁面與分類。
- `/Log/`: 處理日誌，紀錄已處理的檔案與日期。
- `concepts.txt`, `entities.txt`, `sources.txt`: 系統根目錄下的追蹤清單，用於快速核對各類別檔案狀態。

## 3. 三大核心動作 (The Three Actions)

### 🔄 Ingest (吸收與同步)
1. **掃描**: 對比 `Raw/` 與 `Log/`，找出尚未紀錄的新檔案。
2. **分析**: 提取核心概念 (Concepts) 與實體 (Entities)。
3. **寫入 Source**: 在 `/Wiki/Sources/` 建立摘要頁面。
4. **更新 Wiki**: 建立或合併頁面。若頁面已存在，則合併新內容，不可覆蓋舊內容。**Entity 必須遵循命名規範。**
5. **更新 Index & Log**: 將新頁面加入 `Index.md` 並記錄處理日誌。

### 💬 Query (提問與回寫)
1. **檢索**: 優先閱讀 `Index.md` 與相關 Wiki 頁面以獲得情境。
2. **回答**: 基於現有知識庫回答問題。
3. **回寫 (Back-write)**: **(自動執行)** 在完成高品質的分析或回答後，主動將內容整理為新的 Wiki 頁面，無須再次詢問用戶。

### 🔍 Lint (體檢與優化)
1. **檢測**: 定期檢查知識庫，尋找矛盾內容、孤立頁面或過時技術。
2. **校對**: 確保所有頁面符合格式規範與命名準則。
3. **連結修復**: 檢查並修復失效的 `[[雙向連結]]`。

## 4. Wiki 頁面格式要求
- **YAML Frontmatter**: 必須包含 `created`, `updated`, `tags`, `type` (concept/entity/source)。
- **標題**: 使用一級標題 `#`。
- **Entity 命名規範**: 為取代資料夾分類，Entity 檔案必須加上類別前綴：
    - `People_名稱.md` (人物)
    - `Organizations_名稱.md` (組織)
    - `Software_名稱.md` (軟體)
    - `Tools_名稱.md` (工具)
- **雙向連結**: 積極使用 `[[連結]]`，確保檔案名稱與連結完全一致。
- **來源溯源**: Concept/Entity 頁面下方必須標註 `## 來源` 並連結至 `/Wiki/Sources/` 內的對應頁面。

## 5. 交互原則與部署
- **優先檢索**: 優先使用 `grep_search` 確認內容是否已存在。
- **自主回寫**: 根據指令，分析後應直接執行 Ingest 動作更新 Wiki，僅在大規模架構變動或具高度歧義時才詢問。
- **透明度**: 在執行更新時，簡述已完成或正在進行的操作。
- **主動性**: 在 Ingest 過程中主動建立強關聯連結，發現矛盾時主動提醒。

### 初始化與部署 (Initialization & Deployment)
當收到「部署」或「初始化」指令時，應自主執行：
1. **建立目錄結構**：建立 `Raw`, `Wiki/Concepts`, `Wiki/Entities`, `Wiki/Sources`, `Log` 等資料夾。
2. **初始化索引**：建立 `Index.md` 並寫入基礎分類架構。
3. **確認完成**：回報進度並準備接收資料。

---
**最後更新日期時間：2026-05-17 12:53:27**
