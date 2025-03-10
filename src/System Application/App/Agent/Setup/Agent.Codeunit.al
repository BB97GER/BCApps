// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------

namespace System.Agents;

using System.Reflection;
using System.Security.AccessControl;

codeunit 4321 Agent
{
    InherentEntitlements = X;
    InherentPermissions = X;

    /// <summary>
    /// Creates a new agent.
    /// The agent will be in the disabled state, with the users that can interact with the agent setup.
    /// </summary>
    /// <param name="AgentMetadataProvider">The metadata provider of the agent.</param>
    /// <param name="UserName">User name for the agent.</param>
    /// <param name="UserDisplayName">Display name for the agent.</param>
    /// <param name="Instructions">Instructions for the agent that will be used to complete the tasks.</param>
    /// <param name="TempAgentAccessControl">The list of users that can configure or interact with the agent.</param>
    /// <returns>The ID of the agent.</returns>
#pragma warning disable AS0026
    [Scope('OnPrem')]
    procedure Create(AgentMetadataProvider: Enum "Agent Metadata Provider"; UserName: Code[50]; UserDisplayName: Text[80]; var TempAgentAccessControl: Record "Agent Access Control" temporary): Guid
#pragma warning restore AS0026
    var
        AgentImpl: Codeunit "Agent Impl.";
    begin
        exit(AgentImpl.CreateAgent(AgentMetadataProvider, UserName, UserDisplayName, TempAgentAccessControl));
    end;

    /// <summary>
    /// Activates the agent
    /// </summary>
    /// <param name="AgentUserSecurityID">The user security ID of the agent.</param>
    [Scope('OnPrem')]
    procedure Activate(AgentUserSecurityID: Guid)
    var
        AgentImpl: Codeunit "Agent Impl.";
    begin
        AgentImpl.Activate(AgentUserSecurityID);
    end;

    /// <summary>
    /// Deactivates the agent
    /// </summary>
    /// <param name="AgentUserSecurityID">The user security ID of the agent.</param>
    [Scope('OnPrem')]
    procedure Deactivate(AgentUserSecurityID: Guid)
    var
        AgentImpl: Codeunit "Agent Impl.";
    begin
        AgentImpl.Deactivate(AgentUserSecurityID);
    end;

    /// <summary>
    /// Get the display name of the agent.
    /// </summary>
    /// <param name="AgentUserSecurityID">The user security ID of the agent.</param>
    [Scope('OnPrem')]
    procedure GetDisplayName(AgentUserSecurityID: Guid): Text[80]
    var
        AgentImpl: Codeunit "Agent Impl.";
    begin
        exit(AgentImpl.GetDisplayName(AgentUserSecurityID));
    end;

    /// <summary>
    /// Get the user name of the agent.
    /// </summary>
    /// <param name="AgentUserSecurityID">The user security ID of the agent.</param>
    [Scope('OnPrem')]
    procedure GetUserName(AgentUserSecurityID: Guid): Code[50]
    var
        AgentImpl: Codeunit "Agent Impl.";
    begin
        exit(AgentImpl.GetUserName(AgentUserSecurityID));
    end;

    /// <summary>
    /// Sets the display name of the agent.
    /// </summary>
    /// <param name="AgentUserSecurityID">The user security ID of the agent.</param>
    /// <param name="DisplayName">The display name of the agent.</param>
    [Scope('OnPrem')]
    procedure SetDisplayName(AgentUserSecurityID: Guid; DisplayName: Text[80])
    var
        AgentImpl: Codeunit "Agent Impl.";
    begin
        AgentImpl.SetDisplayName(AgentUserSecurityID, DisplayName);
    end;

    /// <summary>
    /// Set the instructions which agent will use to complete the tasks.
    /// </summary>
    /// <param name="Agent">The agent which instructions will be set.</param>
    /// <param name="Instructions">Instructions for the agent that will be used to complete the tasks.</param>
    [Scope('OnPrem')]
    procedure SetInstructions(AgentUserSecurityID: Guid; Instructions: SecretText)
    var
        AgentImpl: Codeunit "Agent Impl.";
    begin
        AgentImpl.SetInstructions(AgentUserSecurityID, Instructions);
    end;

    /// <summary>
    /// Checks if the agent is active.
    /// </summary>
    /// <param name="AgentUserSecurityID">The user security ID of the agent.</param>
    /// <returns>If the agent is active.</returns>
    [Scope('OnPrem')]
    procedure IsActive(AgentUserSecurityID: Guid): Boolean
    var
        AgentImpl: Codeunit "Agent Impl.";
    begin
        exit(AgentImpl.IsActive(AgentUserSecurityID));
    end;

    /// <summary>
    /// Assigns the permission set to the agent.
    /// </summary>
    /// <param name="AgentUserSecurityID">The user security ID of the agent.</param>
    /// <param name="AllProfile">Profile to set to the agent.</param>
    [Scope('OnPrem')]
    procedure SetProfile(AgentUserSecurityID: Guid; var AllProfile: Record "All Profile")
    var
        AgentImpl: Codeunit "Agent Impl.";
    begin
        AgentImpl.SetProfile(AgentUserSecurityID, AllProfile);
    end;

    /// <summary>
    /// Assigns the permission set to the agent.
    /// </summary>
    /// <param name="AgentUserSecurityID">The user security ID of the agent.</param>
    /// <param name="AggregatePermissionSet">Permission sets to assign</param>
    [Scope('OnPrem')]
    procedure AssignPermissionSet(AgentUserSecurityID: Guid; var AggregatePermissionSet: Record "Aggregate Permission Set")
    var
        AgentImpl: Codeunit "Agent Impl.";
    begin
        AgentImpl.AssignPermissionSets(AgentUserSecurityID, CompanyName(), AggregatePermissionSet);
    end;

    /// <summary>
    /// Gets the users that can manage or give tasks to the agent.
    /// </summary>
    /// <param name="AgentUserSecurityID">Security ID of the agent.</param>
    /// <param name="TempAgentAccessControl">List of users that can manage or give tasks to the agent.</param>
    [Scope('OnPrem')]
    procedure GetUserAccess(AgentUserSecurityID: Guid; var TempAgentAccessControl: Record "Agent Access Control" temporary)
    var
        AgentImpl: Codeunit "Agent Impl.";
    begin
        AgentImpl.GetUserAccess(AgentUserSecurityID, TempAgentAccessControl);
    end;

    /// <summary>
    /// Sets the users that can manage or give tasks to the agent. Existing set of users will be replaced with a new set.
    /// </summary>
    /// <param name="AgentUserSecurityID">Security ID of the agent.</param>
    /// <param name="TempAgentAccessControl">List of users that can manage or give tasks to the agent.</param>
    [Scope('OnPrem')]
    procedure UpdateAccess(AgentUserSecurityID: Guid; var TempAgentAccessControl: Record "Agent Access Control" temporary)
    var
        AgentImpl: Codeunit "Agent Impl.";
    begin
        AgentImpl.UpdateAgentAccessControl(AgentUserSecurityID, TempAgentAccessControl);
    end;
}